import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxbazaar/core/themes.dart';
import 'package:maxbazaar/core/utils/constants.dart';
import 'package:maxbazaar/features/auth/presentation/pages/verify_otp_page.dart';
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

              return SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      // Top Carousel
                      Expanded(
                        flex: isMobile ? 6 : 4,
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
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  hintText: "Enter mobile number to Login",
                                  hintStyle: AppFonts.lexendMedium.copyWith(
                                    color: Colors.grey,
                                    fontSize: isMobile ? 16 : 20,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.dialer_sip_sharp,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Continue button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueGrey[300],
                                    padding: EdgeInsets.symmetric(
                                      vertical: isMobile ? 16 : 20,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: isLoading
                                      ? null
                                      : () {
                                          final phoneNo = int.tryParse(
                                            _phoneNoCtrl.text.trim(),
                                          );
                                          if (phoneNo != null) {
                                            context.read<AuthBloc>().add(
                                              SendOtpRequestedEvent(phoneNo),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Enter valid phone number",
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                  child: Text(
                                    isLoading ? 'Signing in...' : 'Continue',
                                    style: AppFonts.lexendExtraBold.copyWith(
                                      color: Colors.white,
                                      fontSize: isMobile ? 16 : 20,
                                    ),
                                  ),
                                ),
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
                              SizedBox(
                                width: double.infinity,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.deepPurpleAccent.shade700,
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      padding: EdgeInsets.symmetric(
                                        vertical: isMobile ? 16 : 20,
                                      ),
                                    ),
                                    onPressed: () {
                                      // Guest flow here
                                    },
                                    child: Text(
                                      "Continue As Guest",
                                      style: AppFonts.lexendExtraBold.copyWith(
                                        color: Colors.white,
                                        fontSize: isMobile ? 16 : 20,
                                      ),
                                    ),
                                  ),
                                ),
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
