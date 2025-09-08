import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:maxbazaar/core/error/exceptions.dart';
import 'package:maxbazaar/core/storage/token_storage.dart';
import 'package:maxbazaar/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:maxbazaar/features/auth/domain/entities/user.dart';
import 'package:maxbazaar/features/auth/domain/repository/iauth_repository.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final AuthRemoteDataSource remote;
  final TokenStorage storage;

  AuthRepositoryImpl({required this.remote, required this.storage});

  @override
  Future<Login> userLogin({required int phoneNo}) async {
    try {
      final model = await remote.userLogin(phoneNo);
      if (model.access != null) {
        await storage.saveAccessToken(model.access!);
      }
      if (model.refresh != null) {
        await storage.saveRefreshToken(model.refresh!);
      }
      return model;
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Login failed';
      final statusCode = e.response?.statusCode;
      throw ServerException(message, statusCode);
    } catch (e) {
      log("Login Unexpected Error: $e");
      throw ServerException('Login failed', null);
    }
  }

  @override
  Future<Login> userRegistration({
    required int phoneNo,
    required String role,
  }) async {
    try {
      //  Get access token from storage
      final accessToken = await storage.getAccessToken();

      // Call remote API with token in Authorization header
      final model = await remote.userRegistration(
        phoneNo,
        role,
        accessToken: accessToken,
      );

      // Save new tokens if backend issues them again
      if (model.access != null) {
        await storage.saveAccessToken(model.access!);
      }
      if (model.refresh != null) {
        await storage.saveRefreshToken(model.refresh!);
      }

      return model;
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] ?? 'Registration failed',
        e.response?.statusCode,
      );
    } catch (_) {
      throw ServerException('Registration failed', null);
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
