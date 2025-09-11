import 'package:flutter/material.dart';
import 'package:maxbazaar/core/themes.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? bgColor;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.bgColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return SizedBox(
      width: width * 0.85, // 85% of screen width
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor ?? ButtonColor.bgColor,
          padding: EdgeInsets.symmetric(
            vertical: height * 0.02, // 2% of screen height
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(width * 0.02), // 2% radius
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: AppFonts.lexendExtraBold.copyWith(
            color: textColor ?? Colors.white,
            fontSize: width * 0.045, // adaptive font size ~4.5% of width
          ),
        ),
      ),
    );
  }
}
