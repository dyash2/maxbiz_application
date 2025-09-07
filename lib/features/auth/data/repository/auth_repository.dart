import 'package:dio/dio.dart';
import 'package:maxbiz_app/core/error/exceptions.dart';
import 'package:maxbiz_app/core/storage/token_storage.dart';
import 'package:maxbiz_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:maxbiz_app/features/auth/domain/entities/user.dart';
import 'package:maxbiz_app/features/auth/domain/repository/iauth_repository.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final AuthRemoteDataSource remote;
  final TokenStorage storage;

  AuthRepositoryImpl({required this.remote, required this.storage});

  @override
  Future<User> login({
    required String username,
    required String password,
  }) async {
    try {
      final model = await remote.login(username, password);
      await storage.saveAccessToken(model.accessToken);
      await storage.saveRefreshToken(model.refreshToken);
      return model;
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] ?? 'Login failed',
        e.response?.statusCode,
      );
    } catch (_) {
      throw ServerException('Login failed', null);
    }
  }

  @override
  Future<String> refresh(String refreshToken) async {
    try {
      final newAccess = await remote.refresh(refreshToken);
      await storage.saveAccessToken(newAccess);
      return newAccess;
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] ?? 'Refresh failed',
        e.response?.statusCode,
      );
    } catch (_) {
      throw ServerException('Refresh failed', null);
    }
  }

  @override
  Future<void> logout(String refreshToken) async {
    try {
      await remote.logout(refreshToken);
      await storage.clear();
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] ?? 'Logout failed',
        e.response?.statusCode,
      );
    } catch (_) {
      throw ServerException('Logout failed', null);
    }
  }
}
