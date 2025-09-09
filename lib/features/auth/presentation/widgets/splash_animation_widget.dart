import 'package:flutter/material.dart';
import 'package:maxbazaar/core/themes.dart';

class SplashAnimationWidget extends StatefulWidget {
  const SplashAnimationWidget({super.key});

  @override
  State<SplashAnimationWidget> createState() => _SplashAnimationWidgetState();
}

class _SplashAnimationWidgetState extends State<SplashAnimationWidget> {
  bool _animateImage = false;
  bool _animateText = false;

  @override
  void initState() {
    super.initState();

    // Start image rising animation
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _animateImage = true;
      });

      // Start text animation after image animation duration
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _animateText = true;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Centered image rising animation
          AnimatedAlign(
            duration: const Duration(seconds: 2),
            curve: Curves.easeOut,
            alignment: _animateImage ? Alignment.center : Alignment.bottomCenter,
            child: AnimatedScale(
              duration: const Duration(seconds: 2),
              curve: Curves.easeOut,
              scale: _animateImage ? 2.5 : 3,
              child: Image.asset(
                "assets/images/splash_icon.png",
                height: 150,
                width: 150,
              ),
            ),
          ),
      
          // Text sliding up animation (always in tree)
          AnimatedAlign(
            duration: const Duration(seconds: 1),
            curve: Curves.easeOut,
            alignment: _animateText
                ? const Alignment(0, 0.8) // 10% above bottom
                : Alignment.bottomCenter,
            child: AnimatedOpacity(
              opacity: _animateText ? 1 : 0, // fade in after animation
              duration: const Duration(seconds: 1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                    style: AppFonts.lexendBold.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
