import 'package:dio/dio.dart';
import 'package:maxbiz_app/core/utils/constants.dart';
import '../../data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String username, String password);
  Future<String> refresh(String refreshToken);
  Future<void> logout(String refreshToken);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> login(String username, String password) async {
    final res = await dio.post(
      Constants.loginPath,
      data: {'username': username, 'password': password},
    );
    return UserModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<String> refresh(String refreshToken) async {
    final res = await dio.post(
      Constants.refreshPath,
      data: {'refreshToken': refreshToken /*, 'expiresInMins': 30*/},
      options: Options(headers: {'Authorization': null}),
    );
    final data = res.data as Map<String, dynamic>;
    return (data['token'] ?? data['accessToken']).toString();
  }

  @override
  Future<void> logout(String refreshToken) async {
    await dio.post(Constants.logoutPath, data: {'refreshToken': refreshToken});
  }
}
