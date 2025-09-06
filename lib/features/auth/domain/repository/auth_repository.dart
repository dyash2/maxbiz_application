import 'package:maxbiz_app/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Login?> login(String phone, String otp);
  Future<Login?> register(String phone, String otp);
  Future<void> logout();
  Login? getCurrentUser();
}
