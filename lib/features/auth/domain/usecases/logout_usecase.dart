import 'package:maxbazaar/features/auth/domain/repository/iauth_repository.dart';

class LogoutUseCase {
  final IAuthRepository repo;
  LogoutUseCase(this.repo);

  Future<void> call(String refreshToken) => repo.logout(refreshToken);
}
