import 'package:maxbazaar/features/auth/domain/entities/otp.dart';

import '../entities/login.dart';

abstract class IAuthRepository {
  Future<Login> userLogin({required int phoneNo});
  Future<Login> userRegistration({required int phoneNo, required String role});
  Future<Otp> sendOtp({required int phoneNo});
  Future<Otp> verifyOtp({required int phoneNo, required int otp});
  Future<void> logout(String refreshToken);
}
