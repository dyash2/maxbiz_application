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
  final String username;
  final String password;

  const LoginRequestedEvent(this.username, this.password);

  @override
  List<Object?> get props => [username, password];
}

class LogoutRequestedEvent extends AuthEvent {
  const LogoutRequestedEvent();
}
