import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxbazaar/core/storage/token_storage.dart';
import 'package:maxbazaar/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:maxbazaar/features/auth/presentation/bloc/auth_event.dart';
import 'package:maxbazaar/features/auth/presentation/bloc/auth_state.dart';
import 'package:maxbazaar/features/home/presentation/pages/home_page.dart';

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
            final statusCode = state.otp.code;
            if (statusCode == 2002) {
              context.read<AuthBloc>().add(LoginRequestedEvent(9764502585));
              log("Verified OTP, now login API will be fired...");
            } else if (statusCode == 2003) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.otp.message)));
              log("Invalid OTP (2003)");
            }
          }

          if (state is AuthAuthenticatedState) {
            tokenStorage.saveAccessToken(state.user.access!);
            tokenStorage.saveRefreshToken(state.user.refresh!);

            log("Access Token Saved: ${state.user.access}");
            log("Refresh Token Saved: ${state.user.refresh}");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthAuthenticatedState) {
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

                    if (otp != null) {
                      context.read<AuthBloc>().add(
                        VerifyOtpRequestedEvent(9764502585, otp),
                      );
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
