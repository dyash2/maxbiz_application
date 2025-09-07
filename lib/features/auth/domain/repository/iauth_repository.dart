import '../entities/user.dart';

abstract class IAuthRepository {
  Future<User> login({required String username, required String password});
  Future<String> refresh(String refreshToken);
  Future<void> logout(String refreshToken);
}
