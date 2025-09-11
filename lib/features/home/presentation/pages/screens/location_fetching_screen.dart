import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:maxbazaar/core/themes.dart';

class LocationFetchingScreen extends StatelessWidget {
  const LocationFetchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/mapImage.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieBuilder.asset(
                "assets/lottie/locationWelcome.json",
                fit: BoxFit.contain,
              ),
              Text(
                "Delivering to Mumbai",
                style: AppFonts.lexendBold.copyWith(
                  fontSize: 20,
                  color: Colors.redAccent.shade200,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  textAlign: TextAlign.center,
                  "Beach Resort - The Walk - Jumeirah Beach Residence - Dubai - United Arab Emirates",
                  style: AppFonts.lexendRegular.copyWith(
                    fontSize: 15,
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.normal,
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
