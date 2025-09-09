import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxbazaar/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:maxbazaar/features/auth/presentation/bloc/auth_event.dart';
import 'package:maxbazaar/features/auth/presentation/bloc/auth_state.dart';
import 'package:maxbazaar/features/presentation/pages/home_page.dart';
import 'verify_otp_page.dart';

class FetchOtpPage extends StatefulWidget {
  const FetchOtpPage({super.key});

  @override
  State<FetchOtpPage> createState() => _FetchOtpPageState();
}

class _FetchOtpPageState extends State<FetchOtpPage> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Send OTP")),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSentOtpState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    VerifyOtpPage(phoneNo: state.phoneNo.toString()),
              ),
            );
          } else if (state is AuthErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoadingState;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Phone Number",
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          final phone = int.tryParse(
                            _phoneController.text.trim(),
                          );
                          if (phone != null) {
                            context.read<AuthBloc>().add(
                              SendOtpRequestedEvent(phone),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Enter valid phone number"),
                              ),
                            );
                          }
                        },
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Send OTP"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class VerifyOtpPage extends StatefulWidget {
  final String phoneNo;
  const VerifyOtpPage({super.key, required this.phoneNo});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify OTP")),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticatedState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
              (route) => false,
            );
          } else if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoadingState;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Phone: ${widget.phoneNo}"),
                const SizedBox(height: 20),
                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter OTP",
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          final otp = int.tryParse(_otpController.text.trim());
                          final phone = int.tryParse(widget.phoneNo);

                          if (otp != null && phone != null) {
                            context.read<AuthBloc>().add(
                                  VerifyOtpRequestedEvent(phone, otp),
                                );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please enter a valid OTP"),
                              ),
                            );
                          }
                        },
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Verify OTP"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

