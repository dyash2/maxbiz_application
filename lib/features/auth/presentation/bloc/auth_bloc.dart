import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxbiz_app/features/auth/domain/entities/user.dart';
import 'package:maxbiz_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:maxbiz_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:maxbiz_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:maxbiz_app/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc({required this.loginUseCase, required this.logoutUseCase})
    : super(AuthInitialState()) {
    on<LoginRequestedEvent>(_onLoginRequested);
    on<LogoutRequestedEvent>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    try {
      final User user = await loginUseCase(
        username: event.username,
        password: event.password,
      );
      emit(AuthAuthenticatedState(user));
    } catch (e) {
      log(e.toString());
      emit(AuthErrorState(e.toString()));
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
    } catch (e) {
      log(e.toString());
      emit(AuthErrorState(e.toString()));
    }
  }
}
