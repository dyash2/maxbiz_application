import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxbazaar/features/auth/domain/entities/user.dart';
import 'package:maxbazaar/features/auth/domain/usecases/login_usecase.dart';
import 'package:maxbazaar/features/auth/domain/usecases/logout_usecase.dart';
import 'package:maxbazaar/features/auth/domain/usecases/registration_usecase.dart';
import 'package:maxbazaar/features/auth/presentation/bloc/auth_event.dart';
import 'package:maxbazaar/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegistrationUsecase registrationUsecase;
  final LogoutUseCase logoutUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registrationUsecase,
    required this.logoutUseCase,
  }) : super(AuthInitialState()) {
    on<LoginRequestedEvent>(_onLoginRequested);
    on<RegisterRequestedEvent>(_onRegisterRequested);
    on<LogoutRequestedEvent>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    try {
      final Login user = await loginUseCase(phoneNo: event.phoneNo);
      emit(AuthAuthenticatedState(user));
    } catch (e, stackTrace) {
      // Print actual error for debugging
      log("Login Error: $e", stackTrace: stackTrace);

      // Emit a user-friendly error
      emit(const AuthErrorState("Login Failed"));
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    try {
      final Login user = await registrationUsecase(
        phoneNo: event.phoneNo,
        role: event.role,
      );
      emit(AuthAuthenticatedState(user));
    } catch (e, stackTrace) {
      log("Registration Error: $e", stackTrace: stackTrace);
      emit(const AuthErrorState("Registration Failed"));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    try {
      await logoutUseCase.call('');
      emit(AuthInitialState());
    } catch (e, stackTrace) {
      log("Logout Error: $e", stackTrace: stackTrace);
      emit(const AuthErrorState("Logout Failed"));
    }
  }
}
