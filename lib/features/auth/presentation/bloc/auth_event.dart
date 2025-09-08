// abstract class AuthEvent {}

// class LoginEvent extends AuthEvent {
//   final String phone;
//   final String otp;

//   LoginEvent(this.phone, this.otp);
// }

// class RegisterEvent extends AuthEvent {
//   final String phone;
//   final String otp;

//   RegisterEvent(this.phone, this.otp);
// }

// class LogoutEvent extends AuthEvent {}

import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class LoginRequestedEvent extends AuthEvent {
  final int phoneNo;

  const LoginRequestedEvent(this.phoneNo);

  @override
  List<Object?> get props => [phoneNo];
}

class RegisterRequestedEvent extends AuthEvent {
  final int phoneNo;
  final String role;

  const RegisterRequestedEvent(this.phoneNo, this.role);

  @override
  List<Object?> get props => [phoneNo, role];
}

class LogoutRequestedEvent extends AuthEvent {
  const LogoutRequestedEvent();
}
