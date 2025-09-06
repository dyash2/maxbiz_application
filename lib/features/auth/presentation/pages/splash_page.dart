import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 200),
            // Top logo
            Center(child: Image.asset("assets/images/splash_icon.png")),
            Spacer(),
            // Bottom text
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  Image.asset(
                    "assets/icons/frying-pan.png",
                    height: 80,
                    width: 80,
                  ),
                  const SizedBox(height: 8),
                   Text(
                    "Crafted with love by Co.Name ❤️",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
