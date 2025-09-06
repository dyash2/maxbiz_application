abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String phone;
  final String otp;

  LoginEvent(this.phone, this.otp);
}

class RegisterEvent extends AuthEvent {
  final String phone;
  final String otp;

  RegisterEvent(this.phone, this.otp);
}

class LogoutEvent extends AuthEvent {}
