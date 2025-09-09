import 'package:maxbazaar/features/auth/domain/entities/otp.dart';

class OtpModel extends Otp {
  OtpModel({required super.code, required super.message, required super.status});

  factory OtpModel.fromJson(Map<String, dynamic> json) {
    return OtpModel(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
