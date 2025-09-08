import 'package:dio/dio.dart';
import 'package:maxbazaar/core/utils/constants.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginModel> userLogin(int phoneNo);
  Future<LoginModel> userRegistration(int phoneNo, String role,{String? accessToken});
  Future<void> logout(String refreshToken);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<LoginModel> userLogin(int phoneNo) async {
    final res = await dio.post(
      Constants.loginPath,
      data: {'phone_no': phoneNo},
    );
    return LoginModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<LoginModel> userRegistration(
    int phoneNo,
    String role, {
    String? accessToken,
  }) async {
    final res = await dio.post(
      Constants.registerPath,
      data: {'phone_no': phoneNo, 'role': role},
      options: Options(
        headers: {
          if (accessToken != null) 'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    return LoginModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<void> logout(String refreshToken) async {
    await dio.post(Constants.logoutPath, data: {'refreshToken': refreshToken});
  }
}
