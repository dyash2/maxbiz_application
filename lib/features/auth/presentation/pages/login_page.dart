import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxbazaar/core/themes.dart';
import 'package:maxbazaar/core/utils/constants/constants.dart';
import 'package:maxbazaar/core/utils/snackbar_utils.dart';
import 'package:maxbazaar/features/auth/presentation/pages/verify_otp_page.dart';
import 'package:maxbazaar/features/auth/presentation/widgets/custom_button.dart';
import 'package:maxbazaar/features/home/presentation/pages/home_page.dart';
import '../../presentation/bloc/auth_bloc.dart';
import '../../presentation/bloc/auth_event.dart';
import '../../presentation/bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneNoCtrl = TextEditingController(text: '');
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _phoneNoCtrl.addListener(() {
      setState(() {}); // rebuild UI when text changes
    });
  }

  @override
  void dispose() {
    _phoneNoCtrl.dispose();
    super.dispose();
  }

  final List<String> images = [
    "assets/icons/food1.jpg",
    "assets/icons/food2.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSentOtpState) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) =>
                    VerifyOtpPage(phoneNo: _phoneNoCtrl.text.toString()),
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
          return LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              final isMobile = screenWidth < 600;
              final phoneNo = _phoneNoCtrl.text.trim();
              final phoneNoLength = phoneNo.length;

              log("Phone number length: $phoneNoLength");

              return SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      // Top Carousel
                      Expanded(
                        flex: isMobile ? 5 : 4,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            PageView.builder(
                              controller: _pageController,
                              itemCount: images.length,
                              onPageChanged: (index) {
                                setState(() {
                                  _currentPage = index;
                                });
                              },
                              itemBuilder: (context, index) {
                                return Image.asset(
                                  images[index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      // Input & Buttons
                      Expanded(
                        flex: isMobile ? 6 : 5,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 20 : screenWidth * 0.1,
                            vertical: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Title
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Register ",
                                      style: AppFonts.pacifico.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: isMobile ? 20 : 28,
                                        color: Colors.orange,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Your Number",
                                      style: AppFonts.lexendSemiBold.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: isMobile ? 20 : 28,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Phone input
                              TextField(
                                controller: _phoneNoCtrl,
                                style: AppFonts.lexendBold.copyWith(
                                  fontSize: isMobile ? 18 : 22,
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                maxLength: 10,
                                decoration: InputDecoration(
                                  counterText: "",
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  hintText: "Enter mobile number to Login",
                                  hintStyle: AppFonts.lexendMedium.copyWith(
                                    color: Colors.grey,
                                    fontSize: isMobile ? 16 : 20,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: Colors.blueGrey.shade500,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Continue button
                              CustomButton(
                                bgColor: _phoneNoCtrl.text.trim().length == 10
                                    ? Colors.orange
                                    : ButtonColor.bgColor,
                                text: isLoading ? 'Signing in...' : 'Continue',
                                onPressed:
                                    (_phoneNoCtrl.text.trim().length == 10 &&
                                        !isLoading)
                                    ? () {
                                        final phoneNo = int.tryParse(
                                          _phoneNoCtrl.text.trim(),
                                        );
                                        if (phoneNo != null) {
                                          context.read<AuthBloc>().add(
                                            SendOtpRequestedEvent(phoneNo),
                                          );
                                        } else {
                                          SnackBarUtils.showWarning(
                                            context,
                                            "Enter a valid 10-digit phone number",
                                          );
                                        }
                                      }
                                    : null, // disabled if not valid
                              ),

                              const SizedBox(height: 10),

                              // OR divider
                              Row(
                                children: const [
                                  Expanded(child: Divider()),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Text("OR"),
                                  ),
                                  Expanded(child: Divider()),
                                ],
                              ),
                              const SizedBox(height: 10),

                              // Continue as Guest button
                              CustomButton(
                                text: "Continue As Guest",
                                textColor: Colors.white,
                                bgColor: Colors.deepPurpleAccent.shade700,
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ),
                                    (route) => false,
                                  );
                                },
                              ),
                              const Spacer(),

                              // Terms and Policy
                              Center(
                                child: Text.rich(
                                  TextSpan(
                                    text: "By proceeding, I agree to the ",
                                    style: AppFonts.lexendBold.copyWith(
                                      fontSize: isMobile ? 12 : 14,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Terms of Service",
                                        style: AppFonts.lexendBold.copyWith(
                                          color: Colors.orange[800],
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.orange[800],
                                        ),
                                      ),
                                      TextSpan(
                                        text: " and ",
                                        style: AppFonts.lexendBold.copyWith(),
                                      ),
                                      TextSpan(
                                        text: "Privacy Policy",
                                        style: AppFonts.lexendBold.copyWith(
                                          color: Colors.orange[800],
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.orange[800],
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
