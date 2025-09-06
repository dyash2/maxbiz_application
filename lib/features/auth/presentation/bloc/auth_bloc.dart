import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxbiz_app/features/auth/domain/usecases/login_user.dart';
import 'package:maxbiz_app/features/auth/domain/usecases/logout_user.dart';
import 'package:maxbiz_app/features/auth/domain/usecases/register_user.dart';
import 'package:maxbiz_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:maxbiz_app/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final RegisterUser registerUser;
  final LogoutUser logoutUser;

  AuthBloc({
    required this.loginUser,
    required this.registerUser,
    required this.logoutUser,
  }) : super(AuthState.initial()) {
    // 🔹 Login with phone + otp
    on<LoginEvent>((event, emit) async {
      log("LoginEvent received for phone: ${event.phone}");

      emit(state.copyWith(status: AuthStatus.loading));

      try {
        final user = await loginUser(event.phone, event.otp);
        if (user != null) {
          log("User logged in: ${user.phone}");
          emit(state.copyWith(status: AuthStatus.authenticated, user: user));
        } else {
          emit(
            state.copyWith(
              status: AuthStatus.error,
              errorMessage: "Login failed",
            ),
          );
        }
      } catch (e) {
        log("Error in AuthBloc Login: $e");
        emit(
          state.copyWith(status: AuthStatus.error, errorMessage: e.toString()),
        );
      }
    });

    // 🔹 Register with phone + otp
    on<RegisterEvent>((event, emit) async {
      log("RegisterEvent received for phone: ${event.phone}");

      emit(state.copyWith(status: AuthStatus.loading));

      try {
        final user = await registerUser(event.phone, event.otp);
        if (user != null) {
          log("User registered: ${user.phone}");
          emit(state.copyWith(status: AuthStatus.authenticated, user: user));
        } else {
          emit(
            state.copyWith(
              status: AuthStatus.error,
              errorMessage: "Registration failed",
            ),
          );
        }
      } catch (e) {
        log("Error in AuthBloc Register: $e");
        emit(
          state.copyWith(status: AuthStatus.error, errorMessage: e.toString()),
        );
      }
    });

    // 🔹 Logout
    on<LogoutEvent>((event, emit) async {
      log("LogoutEvent received");

      await logoutUser();
      emit(AuthState.initial());
    });
  }
}
