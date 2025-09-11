import 'package:flutter/material.dart';

class CustomStringTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final bool isMobile;
  final TextInputType? keyboardType;
  final bool requiredField;
  final String? Function(String?)? validator; // ✅ correct type

  const CustomStringTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.controller,
    this.obscureText = false,
    this.isMobile = true,
    this.keyboardType,
    this.requiredField = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        maxLength: 10,
        keyboardType: keyboardType,
        validator:
            validator ??
            (value) {
              if (requiredField && (value == null || value.trim().isEmpty)) {
                return "This field is required";
              }
              return null;
            },
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: Colors.white,
          hintText: hintText, // ✅ hint text without coloring *
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: isMobile ? 16 : 20,
          ),
          prefixIcon: Icon(prefixIcon, color: Colors.blueGrey.shade500),
          suffix: requiredField
              ? const Text(
                  "*",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null, // ✅ red * suffix
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
