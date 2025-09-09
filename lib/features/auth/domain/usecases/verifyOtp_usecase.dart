import 'package:maxbazaar/features/auth/domain/entities/otp.dart';
import 'package:maxbazaar/features/auth/domain/repository/iauth_repository.dart';

class VerifyotpUsecase {
  final IAuthRepository repository;
  VerifyotpUsecase(this.repository);

  Future<Otp> call({required int phoneNo, required int otp}) async {
    return repository.verifyOtp(phoneNo: phoneNo, otp: otp);
  }
}
