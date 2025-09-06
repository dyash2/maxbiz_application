import 'package:flutter/material.dart';
import 'package:maxbiz_app/core/themes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> images = [
    "assets/icons/food1.jpg",
    "assets/icons/food2.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              // Top Carousel
              Expanded(
                flex: 6,
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
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
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
                                fontSize: 20,
                                color: Colors.orange,
                              ),
                            ),
                            TextSpan(
                              text: "Your Number",
                              style: AppFonts.lexendSemiBold.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Phone input
                      TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          hintText: "Enter mobile number to Login",
                          hintStyle: AppFonts.lexendMedium.copyWith(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                          prefixIcon: const Icon(Icons.dialer_sip_sharp),
                          // remove all borders
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
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
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Continue",
                            style: AppFonts.lexendExtraBold.copyWith(
                              color: Colors.white,
                              fontSize: 16,
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
                            padding: EdgeInsets.symmetric(horizontal: 8),
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
                              padding: const EdgeInsets.symmetric(vertical: 20),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Continue As Guest",
                              style: AppFonts.lexendExtraBold.copyWith(
                                color: Colors.white,
                                fontSize: 16,
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
                            style: AppFonts.lexendBold.copyWith(fontSize: 12),
                            children: [
                              TextSpan(
                                text: "Terms of Service",
                                style: AppFonts.lexendBold.copyWith(
                                  color: Colors.orange[800],
                                  fontWeight: FontWeight.bold,
                                  //underline the text
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
      ),
    );
  }
}
