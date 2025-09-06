import 'dart:math';

import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  String? _loggedInPhone;
  final Map<String, String> _otpStore = {}; // phone → otp

  // Request OTP
  Future<String> requestOtp(String phone) async {
    try {
      // 🔹 Generate 6-digit random OTP
      final otp = (Random().nextInt(900000) + 100000).toString();

      // 🔹 Store OTP temporarily
      _otpStore[phone] = otp;

      // In a real app: send OTP via SMS (Twilio, API, etc.)
      print("Generated OTP for $phone: $otp"); // demo only

      return otp; // return for testing
    } catch (e) {
      throw ("Failed to generate OTP");
    }
  }

  // Verify OTP
  Future<bool> verifyOtp(String phone, String otp) async {
    try {
      if (_otpStore.containsKey(phone) && _otpStore[phone] == otp) {
        _loggedInPhone = phone;
        _otpStore.remove(phone); // clear OTP after success
        return true;
      } else {
        throw ("Invalid OTP");
      }
    } catch (e) {
      throw ("Failed to verify OTP");
    }
  }

  // Log out current user
  Future<void> logOut() async {
    try {
      _loggedInPhone = null;
    } catch (e) {
      throw ("Failed to Log Out");
    }
  }

  // Current User
  String? get currentUser => _loggedInPhone;
}


class AutheticationRemoteDataSource{
  final Dio dio;

  AutheticationRemoteDataSource(this.dio);

  Future<String> requestOTP(String otp) async{
    try{
      final recieved = otp.
    }
  }
}