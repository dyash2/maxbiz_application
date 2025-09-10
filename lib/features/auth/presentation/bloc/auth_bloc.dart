import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxbazaar/features/auth/domain/entities/login.dart';
import 'package:maxbazaar/features/auth/domain/entities/otp.dart';
import 'package:maxbazaar/features/auth/domain/usecases/login_usecase.dart';
import 'package:maxbazaar/features/auth/domain/usecases/logout_usecase.dart';
import 'package:maxbazaar/features/auth/domain/usecases/registration_usecase.dart';
import 'package:maxbazaar/features/auth/domain/usecases/sendOtp_usecase.dart';
import 'package:maxbazaar/features/auth/domain/usecases/verifyOtp_usecase.dart';
import 'package:maxbazaar/features/auth/presentation/bloc/auth_event.dart';
import 'package:maxbazaar/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegistrationUsecase registrationUsecase;
  final LogoutUseCase logoutUseCase;
  final SendotpUsecase sendotpUsecase;
  final VerifyotpUsecase verifyotpUsecase;

  AuthBloc({
    required this.loginUseCase,
    required this.registrationUsecase,
    required this.logoutUseCase,
    required this.sendotpUsecase,
    required this.verifyotpUsecase,
  }) : super(AuthInitialState()) {
    on<LoginRequestedEvent>(_onLoginRequested);
    on<RegisterRequestedEvent>(_onRegisterRequested);
    on<LogoutRequestedEvent>(_onLogoutRequested);
    on<SendOtpRequestedEvent>(_onSendOtpRequested);
    on<VerifyOtpRequestedEvent>(_onVerifyOtpRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    try {
      final Login user = await loginUseCase(phoneNo: event.phoneNo);
      emit(AuthAuthenticatedState(user));
      // 👇 Log the API response
      log("Login API Response: ${user.toJson()}");
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
      // emit(AuthRegisterState(event.phoneNo, event.role));
      emit(AuthAuthenticatedState(user));
      log("Registration API Response: ${user.toJson()}");
    } catch (e, stackTrace) {
      log("Registration Error: $e", stackTrace: stackTrace);
      emit(const AuthErrorState("Registration Failed"));
    }
  }

  Future<void> _onSendOtpRequested(
    SendOtpRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    try {
      final Otp otp = await sendotpUsecase(phoneNo: event.phoneNo);
      emit(AuthSentOtpState(otp));
      log("SendOTP API Response: ${otp.toJson()}");
    } catch (e, stackTrace) {
      log("Send OTP Error : $e", stackTrace: stackTrace);
      emit(const AuthErrorState("Send OTP Failed"));
    }
  }

  Future<void> _onVerifyOtpRequested(
    VerifyOtpRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    try {
      final Otp otp = await verifyotpUsecase(
        phoneNo: event.phoneNo,
        otp: event.otp,
      );
      emit(AuthVerifyOtpState(otp));
      log("VerifyOTP API Response: ${otp.toJson()}");
    } catch (e, stackTrace) {
      log("Verify OTP Error: $e", stackTrace: stackTrace);
      emit(const AuthErrorState("Verify OTP Failed"));
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
