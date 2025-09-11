// import 'package:maxbazaar/features/auth/domain/entities/user.dart';

// enum AuthStatus {
//   initial,
//   loading,
//   register,
//   authenticated,
//   unauthenticated,
//   error,
// }

// class AuthState {
//   final AuthStatus status;
//   final User? user;
//   final String errorMessage;

//   const AuthState({required this.status, this.user, this.errorMessage = ''});

//   factory AuthState.initial() {
//     return const AuthState(status: AuthStatus.initial);
//   }

//   AuthState copyWith({AuthStatus? status, User? user, String? errorMessage}) {
//     return AuthState(
//       status: status ?? this.status,
//       user: user ?? this.user,
//       errorMessage: errorMessage ?? this.errorMessage,
//     );
//   }
// }

import 'package:equatable/equatable.dart';
import 'package:maxbazaar/features/auth/domain/entities/login.dart';
import 'package:maxbazaar/features/auth/domain/entities/otp.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}


class AuthSentOtpState extends AuthState {
  final Otp otp;
  const AuthSentOtpState(this.otp);

  // i also don't know  why i have used props here. it's just there
  @override
  List<Object?> get props => [otp];
}

class AuthVerifyOtpState extends AuthState {
  final Otp otp;
  const AuthVerifyOtpState(this.otp);

  @override
  List<Object?> get props => [otp];
}

class AuthRegisterState extends AuthState {
  final int phoneNo;
  final String role;
  const AuthRegisterState(this.phoneNo, this.role);

  @override
  List<Object?> get props => [phoneNo, role];
}

class AuthAuthenticatedState extends AuthState {
  final Login user;
  const AuthAuthenticatedState(this.user);
  @override
  List<Object?> get props => [user];
}

class AuthErrorState extends AuthState {
  final String message;
  const AuthErrorState(this.message);
  @override
  List<Object?> get props => [message];
}
