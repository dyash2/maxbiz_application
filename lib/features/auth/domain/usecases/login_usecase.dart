import 'package:maxbazaar/features/auth/domain/entities/user.dart';
import 'package:maxbazaar/features/auth/domain/repository/iauth_repository.dart';

class LoginUseCase {
  final IAuthRepository repository;
  LoginUseCase(this.repository);

  Future<Login> call({required int phoneNo}) {
    return repository.userLogin(phoneNo: phoneNo);
  }
}
