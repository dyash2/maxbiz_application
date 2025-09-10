import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxbazaar/core/routes/app_routes.dart';
import 'package:maxbazaar/core/storage/token_storage.dart';
import 'package:maxbazaar/features/auth/data/models/otp_model.dart';
import 'package:maxbazaar/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:maxbazaar/features/auth/presentation/bloc/auth_event.dart';
import 'package:maxbazaar/features/auth/presentation/bloc/auth_state.dart';

class PracticePage extends StatefulWidget {
  const PracticePage({super.key});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  final TextEditingController _otpCtrl = TextEditingController();
  final tokenStorage = SharedPrefsTokenStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Auth Practice Page")),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthVerifyOtpState) {
            log("Server Code of Verify OTP : ${state.otp.code}");
          }
        },
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthVerifyOtpState) {
            return Center(
              child: Text(
                "Server Code: ${state.otp.code}\nStatus: ${state.otp.status}\nMessage: ${state.otp.message}",
              ),
            );
          } else if (state is AuthAuthenticatedState) {
            // Save tokens
            // tokenStorage.saveAccessToken(state.user.access, state.user.refresh);
            tokenStorage.saveAccessToken(state.user.access!);
            tokenStorage.saveRefreshToken(state.user.refresh!);

            return Center(
              child: Text(
                "Access Token: ${state.user.access}\nRefresh Token: ${state.user.refresh}",
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Current State: $state"),
                const SizedBox(height: 20),

                TextField(
                  controller: _otpCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Enter OTP",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                      SendOtpRequestedEvent(9764502585),
                    );
                  },
                  child: const Text("Send OTP"),
                ),
                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    final otp = int.tryParse(_otpCtrl.text.trim());

                    context.read<AuthBloc>().add(
                      VerifyOtpRequestedEvent(9764502585, otp!),
                    );
                    context.read<AuthBloc>().add(
                      LoginRequestedEvent(9764502585),
                    );

                    final verifyState = state as AuthVerifyOtpState;
                    final loginState = state as AuthAuthenticatedState;

                    final statusCode = verifyState.otp.code;

                    if (statusCode == 2002) {
                      log("status Code : $statusCode");
                      if (loginState.user.access ==
                          tokenStorage.getAccessToken()) {
                        Center(child: Text("Tokens are same"));
                      }
                    } else {
                      Text("Error");
                    }
                  },
                  child: const Text("Verify OTP"),
                ),
                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                      LoginRequestedEvent(9764502585),
                    );
                  },
                  child: const Text("Login"),
                ),
                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                      RegisterRequestedEvent(9876543210, "Customer"),
                    );
                  },
                  child: const Text("Register"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
