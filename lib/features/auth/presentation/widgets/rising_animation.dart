import 'package:flutter/material.dart';

class RisingImageDemo extends StatefulWidget {
  const RisingImageDemo({super.key});

  @override
  State<RisingImageDemo> createState() => _RisingImageDemoState();
}

class _RisingImageDemoState extends State<RisingImageDemo> {
  bool _animate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _animate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(seconds: 2),
            curve: Curves.easeOut,
            alignment: _animate ? Alignment.center : Alignment.bottomCenter,
            child: AnimatedScale(
              duration: const Duration(seconds: 2),
              curve: Curves.easeOut,
              scale: _animate ? 2.5 : 3,
              child: Image.asset(
                "assets/images/splash_icon.png",
                height: 150,
                width: 150,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
