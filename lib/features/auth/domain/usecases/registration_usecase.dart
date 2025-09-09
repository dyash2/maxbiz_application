import 'package:maxbazaar/features/auth/domain/entities/login.dart';
import 'package:maxbazaar/features/auth/domain/repository/iauth_repository.dart';

class RegistrationUsecase {
  final IAuthRepository repository;

  RegistrationUsecase(this.repository);

  Future<Login> call({
    required int phoneNo,
    required String role,
  }) async {
    return await repository.userRegistration(
      phoneNo: phoneNo,
      role: role,
    );
  }
}
