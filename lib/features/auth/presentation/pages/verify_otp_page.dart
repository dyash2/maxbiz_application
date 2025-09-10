import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxbazaar/core/routes/app_routes.dart';
import 'package:maxbazaar/core/themes.dart';
import 'package:maxbazaar/features/auth/domain/entities/otp.dart';
import 'package:maxbazaar/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:maxbazaar/features/auth/presentation/bloc/auth_event.dart';
import 'package:maxbazaar/features/auth/presentation/bloc/auth_state.dart';
import 'package:maxbazaar/features/auth/presentation/widgets/custom_button.dart';
import 'package:maxbazaar/features/home/presentation/pages/home_page.dart';

class VerifyOtpPage extends StatefulWidget {
  final String phoneNo;
  const VerifyOtpPage({super.key, required this.phoneNo});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final int otpLength = 4;
  final List<TextEditingController> _controllers = [];
  final List<FocusNode> _focusNodes = [];
  int _secondsRemaining = 60;
  final List<Otp> _otp = [];
  Timer? _timer;

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
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        if (mounted) {
          setState(() {
            _secondsRemaining--;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          final isLoading = state is AuthLoadingState;
          if (state is AuthLoadingState){
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthVerifyOtpState){
            
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
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.login,
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

                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Didn't receive OTP?",
                      style: AppFonts.lexendBold.copyWith(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      "00:${_secondsRemaining.toString().padLeft(2, '0')}",
                      style: AppFonts.lexendBold.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),

                  // Verify OTP Button
                  CustomButton(
                    text: "Verify OTP",
                    onPressed: () {
                      isLoading
                          ? null
                          : () {
                              final phoneNo = widget.phoneNo;
                              final parsedPhoneNo = int.tryParse(phoneNo);

                              // Collect OTP entered by user
                              final otp = _controllers
                                  .map((c) => c.text)
                                  .join();
                              final parsedOtp = int.tryParse(otp);

                              // Verify OTP length
                              if (otp.length == otpLength) {
                                context.read<AuthBloc>().add(
                                  VerifyOtpRequestedEvent(
                                    parsedPhoneNo!,
                                    parsedOtp!,
                                  ),
                                );
                                context.read<AuthBloc>().add(
                                  LoginRequestedEvent(parsedPhoneNo),
                                );
                                context.read<AuthBloc>().add(
                                  RegisterRequestedEvent(
                                    parsedPhoneNo,
                                    "Customer",
                                  ),
                                );
                              } else if (_otp.map((e) => e.status) == 2003) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Please enter a valid OTP"),
                                  ),
                                );
                              }
                            };
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
