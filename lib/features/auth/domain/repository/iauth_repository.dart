import '../entities/user.dart';

abstract class IAuthRepository {
  Future<Login> userLogin({required int phoneNo});
  Future<Login> userRegistration({required int phoneNo, required String role});
  Future<void> logout(String refreshToken);
}
