import 'package:maxbazaar/features/auth/domain/entities/register.dart';

class RegisterModel extends Register {
  RegisterModel({required super.status, required super.message});

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(status: json['status'], message: json['message']);
  }
}
