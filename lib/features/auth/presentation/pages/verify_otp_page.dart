import 'dart:async';
import 'dart:math' as m;
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maxbazaar/core/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxbazaar/core/storage/token_storage.dart';
import 'package:maxbazaar/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:maxbazaar/features/auth/presentation/bloc/auth_event.dart';
import 'package:maxbazaar/features/auth/presentation/bloc/auth_state.dart';
import 'package:maxbazaar/features/auth/presentation/pages/login_page.dart';
import 'package:maxbazaar/features/auth/presentation/widgets/custom_button.dart';
import 'package:maxbazaar/features/home/presentation/pages/home_page.dart';

class VerifyOtpPage extends StatefulWidget {
  final String phoneNo;
  const VerifyOtpPage({super.key, required this.phoneNo});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final tokenStorage = SharedPrefsTokenStorage();
  final List<TextEditingController> _controllers = [];
  final List<FocusNode> _focusNodes = [];
  int _secondsRemaining = 60;
  final int otpLength = 4;
  Timer? _timer;
  bool _canResend = false; // ✅ Track if user can resend

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < otpLength; i++) {
      _controllers.add(TextEditingController());
      _focusNodes.add(FocusNode());
    }
    _focusNodes[0].requestFocus();
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
        setState(() {}); // Trigger rebuild to show Resend button
      } else {
        if (mounted) {
          setState(() {
            _secondsRemaining--;
          });
        }
      }
    });
  }

  void _resendOtp(int phoneNo) {
    context.read<AuthBloc>().add(SendOtpRequestedEvent(phoneNo));
    _startTimer();
  }

  @override
  void dispose() {
    for (var controller in _controllers) controller.dispose();
    for (var node in _focusNodes) node.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final phoneNo = int.tryParse(widget.phoneNo.trim());
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthVerifyOtpState) {
            final statusCode = state.otp.code;
            if (statusCode == 2002) {
              context.read<AuthBloc>().add(LoginRequestedEvent(phoneNo!));
              log("Verifed OTP Called,now login api will be fired....");
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
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // back button
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    "Verify OTP",
                    style: AppFonts.lexendExtraBold.copyWith(fontSize: 30),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "91 +${widget.phoneNo}",
                    style: AppFonts.lexendExtraBold.copyWith(
                      fontSize: 20,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 60),

                  // OTP Input Fields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(otpLength, (index) {
                      return SizedBox(
                        width: 80,
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: AppFonts.lexendExtraBold.copyWith(
                            fontSize: 28,
                            color:
                                _controllers[index].text.isNotEmpty &&
                                    !_focusNodes[index].hasFocus
                                ? Colors.orange
                                : Colors.white,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            counterText: "",
                            filled: true,
                            fillColor: _focusNodes[index].hasFocus
                                ? Colors.orange
                                : Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {});
                            if (value.isNotEmpty && index < otpLength - 1) {
                              _focusNodes[index + 1].requestFocus();
                            }
                            if (value.isEmpty && index > 0) {
                              _focusNodes[index - 1].requestFocus();
                            }
                          },
                        ),
                      );
                    }),
                  ),

                 
                  Center(
                    child: _secondsRemaining > 0
                        ? Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Text(
                              "00:${_secondsRemaining.toString().padLeft(2, '0')}",
                              style: AppFonts.lexendBold.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        )
                        : Column(
                            children: [
                              SizedBox(height: 20),
                              Text(
                                "Didn't receive OTP?",
                                style: AppFonts.lexendBold.copyWith(
                                  fontSize: 16,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              SizedBox(height: 10),

                              GestureDetector(
                                onTap: () {
                                  _resendOtp(phoneNo!);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 8,
                                        offset: const Offset(2, 4),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    "Resend OTP",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),

                  const Spacer(),

                  // Verify OTP Buttons
                  CustomButton(
                    text: "Verify OTP",
                    onPressed: () {
                      final otp = _controllers.map((e) => e.text).join();
                      final parsedOtp = int.tryParse(otp);

                      if (parsedOtp != null) {
                        context.read<AuthBloc>().add(
                          VerifyOtpRequestedEvent(phoneNo!, parsedOtp),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  
}
