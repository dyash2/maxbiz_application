import 'package:maxbiz_app/features/auth/domain/repository/iauth_repository.dart';

class RefreshTokenUsecase {
  final IAuthRepository repository;

  RefreshTokenUsecase(this.repository);

  Future<String> call(String refreshToken){
    return repository.refresh(refreshToken);
  }
}