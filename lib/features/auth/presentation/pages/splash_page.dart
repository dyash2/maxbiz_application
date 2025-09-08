import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maxbazaar/features/auth/presentation/pages/login_page.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _handleSplashFlow();
  }

  Future<void> _handleSplashFlow() async {
    await _requestLocationPermission();
    await _startTimer();
  }

  Future<void> _startTimer() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      debugPrint("✅ Location permission granted");
    } else if (status.isDenied) {
      debugPrint("⚠️ Location permission denied");
    } else if (status.isPermanentlyDenied) {
      debugPrint(
          "❌ Location permission permanently denied. Redirecting to settings...");
      await openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 200),
            Center(child: Image.asset("assets/images/splash_icon.png")),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
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
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
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