import 'dart:async';
import 'package:dio/dio.dart';
import '../storage/token_storage.dart';
import '../utils/constants.dart';

class DioClient {
  final Dio dio;
  final TokenStorage tokenStorage;
  bool _isRefreshing = false;
  final List<QueuedRequest> _queue = [];

  DioClient(this.dio, this.tokenStorage) {
    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
      headers: {'Content-Type': 'application/json'},
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await tokenStorage.getAccessToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (e, handler) async {
          // Only handle 401 for non-refresh endpoints
          final isUnauthorized = e.response?.statusCode == 401;
          final isRefreshCall = e.requestOptions.path.endsWith(
            Constants.refreshPath,
          );
          if (isUnauthorized && !isRefreshCall) {
            final reqOptions = e.requestOptions;

            // queue current request
            final completer = Completer<Response>();
            _queue.add(
              QueuedRequest(requestOptions: reqOptions, completer: completer),
            );

            if (!_isRefreshing) {
              _isRefreshing = true;
              try {
                await _performTokenRefresh();
                // retry all queued
                for (final qr in _queue) {
                  try {
                    final newResponse = await _retry(qr.requestOptions);
                    qr.completer.complete(newResponse);
                  } catch (err) {
                    qr.completer.completeError(err);
                  }
                }
              } catch (refreshErr) {
                // propagate failure to queue
                for (final qr in _queue) {
                  qr.completer.completeError(refreshErr);
                }
              } finally {
                _queue.clear();
                _isRefreshing = false;
              }
            }

            try {
              final res = await completer.future;
              return handler.resolve(res);
            } catch (err) {
              return handler.reject(
                err is DioException
                    ? err
                    : DioException(requestOptions: reqOptions, error: err),
              );
            }
          }

          // otherwise passthrough
          return handler.next(e);
        },
      ),
    );
  }

  Future<void> _performTokenRefresh() async {
    final refresh = await tokenStorage.getRefreshToken();
    if (refresh == null || refresh.isEmpty) {
      throw DioException(
        requestOptions: RequestOptions(path: Constants.refreshPath),
        error: 'Refresh token missing',
      );
    }
    final res = await dio.post(
      Constants.refreshPath,
      data: {'refreshToken': refresh /*, 'expiresInMins': 30*/},
      options: Options(
        headers: {'Authorization': null},
      ), // ensure no stale access token
    );

    // DummyJSON returns { "token": "new_access" } (and sometimes also "refreshToken")
    final data = res.data is Map ? res.data as Map : {};
    final newAccess = (data['token'] ?? data['accessToken'])?.toString();
    final newRefresh = (data['refreshToken'])?.toString();

    if (newAccess == null || newAccess.isEmpty) {
      throw DioException(
        requestOptions: RequestOptions(path: Constants.refreshPath),
        error: 'Refresh response missing access token',
      );
    }
    await tokenStorage.saveAccessToken(newAccess);
    if (newRefresh != null && newRefresh.isNotEmpty) {
      await tokenStorage.saveRefreshToken(newRefresh);
    }
  }

  Future<Response> _retry(RequestOptions r) async {
    final newToken = await tokenStorage.getAccessToken();
    final options = Options(
      method: r.method,
      headers: {
        ...?r.headers,
        if (newToken != null) 'Authorization': 'Bearer $newToken',
      },
      responseType: r.responseType,
      sendTimeout: r.sendTimeout,
      receiveTimeout: r.receiveTimeout,
      contentType: r.contentType,
    );
    return dio.request(
      r.path,
      data: r.data,
      queryParameters: r.queryParameters,
      options: options,
      cancelToken: r.cancelToken,
      onReceiveProgress: r.onReceiveProgress,
      onSendProgress: r.onSendProgress,
    );
  }
}

class QueuedRequest {
  final RequestOptions requestOptions;
  final Completer<Response> completer;
  QueuedRequest({required this.requestOptions, required this.completer});
}
