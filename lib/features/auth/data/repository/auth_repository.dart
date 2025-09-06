import 'package:maxbiz_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:maxbiz_app/features/auth/data/models/user_model.dart';
import 'package:maxbiz_app/features/auth/domain/entities/user.dart';
import 'package:maxbiz_app/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  // Request OTP
  Future<String> requestOtp(String phone) async {
    return await remoteDataSource.requestOtp(phone);
  }

  // Verify OTP and login
  @override
  Future<User?> login(String phone, String otp) async {
    final success = await remoteDataSource.verifyOtp(phone, otp);
    return success ? UserModel(phone: phone) : null;
  }

  // Register user (phone only, no password)
  @override
  Future<User?> register(String phone, String otp) async {
    final success = await remoteDataSource.verifyOtp(phone, otp);
    return success ? UserModel(phone: phone) : null;
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logOut();
  }

  @override
  User? getCurrentUser() {
    final phone = remoteDataSource.currentUser;
    return phone != null ? UserModel(phone: phone) : null;
  }
}
