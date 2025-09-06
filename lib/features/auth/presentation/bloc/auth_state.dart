import 'package:maxbiz_app/features/auth/domain/entities/user.dart';

enum AuthStatus {
  initial,
  loading,
  register,
  authenticated,
  unauthenticated,
  error,
}

class AuthState {
  final AuthStatus status;
  final User? user;
  final String errorMessage;

  const AuthState({required this.status, this.user, this.errorMessage = ''});

  factory AuthState.initial() {
    return const AuthState(status: AuthStatus.initial);
  }

  AuthState copyWith({AuthStatus? status, User? user, String? errorMessage}) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
