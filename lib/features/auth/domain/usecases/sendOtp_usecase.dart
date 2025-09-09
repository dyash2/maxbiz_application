import 'package:maxbazaar/features/auth/domain/entities/otp.dart';
import 'package:maxbazaar/features/auth/domain/repository/iauth_repository.dart';

class SendotpUsecase {
  final IAuthRepository repository;
  SendotpUsecase(this.repository);

  Future<Otp> call({required int phoneNo}) async {
    return repository.sendOtp(phoneNo: phoneNo);
  }
}


