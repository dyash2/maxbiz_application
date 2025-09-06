import 'package:maxbiz_app/features/auth/domain/entities/user.dart';
import 'package:maxbiz_app/features/auth/domain/repository/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<User?> call(String phone, String otp) {
    return repository.login(phone, otp);
  }
}
