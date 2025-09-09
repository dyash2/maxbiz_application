import 'dart:async';
import 'package:flutter/material.dart';
import 'package:maxbazaar/core/themes.dart';
import 'package:maxbazaar/features/auth/presentation/pages/login_page.dart';
import 'package:maxbazaar/features/auth/presentation/widgets/splash_animation_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _permanentlyDenied = false;

  @override
  void initState() {
    super.initState();
    _handleSplashFlow();
  }

  Future<void> _handleSplashFlow() async {
    final status = await Permission.location.request();

    if (status.isGranted) {
      // Permission granted → wait for splash duration
      await Future.delayed(const Duration(seconds: 4));
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    } else if (status.isDenied || status.isPermanentlyDenied) {
      // Show modal
      _permanentlyDenied = status.isPermanentlyDenied;
      _showPermissionModal();
    }
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
      _permanentlyDenied = false;
      _showPermissionModal();
    } else if (status.isPermanentlyDenied) {
      debugPrint("❌ Location permission permanently denied");
      _permanentlyDenied = true;
      _showPermissionModal();
    }
  }

  void _showPermissionModal() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                "assets/lottie/location.json",
                height: 100,
                width: 100,
              ),
              const SizedBox(height: 16),
              Text(
                "Your Device's Location Service Is Off.",
                style: AppFonts.lexendExtraBold.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                "To ensure the best delivery service, please enable location permission",
                textAlign: TextAlign.center,
                style: AppFonts.lexendBold.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    Navigator.pop(context);

                    if (_permanentlyDenied) {
                      await openAppSettings();
                    } else {
                      final status = await Permission.location.request();
                      if (status.isGranted) {
                        debugPrint("✅ Location granted after retry");
                      } else {
                        _showPermissionModal();
                      }
                    }
                  },
                  child: Text(
                    _permanentlyDenied ? "Open Settings" : "Use My Location",
                    style: AppFonts.lexendBold.copyWith(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SplashAnimationWidget();
  }
}
