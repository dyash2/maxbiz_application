import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String primaryText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final bool obscureText;
  final bool isMobile;
  final bool requiredField;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.primaryText,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.obscureText = false,
    this.isMobile = true,
    this.requiredField = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hint text with red asterisk
        Row(
          children: [
            Text(
              primaryText,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: isMobile ? 16 : 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (requiredField)
              const Text(
                " *",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            validator:
                validator ??
                (value) {
                  if (requiredField &&
                      (value == null || value.trim().isEmpty)) {
                    return "This field is required";
                  }
                  return null;
                },
            decoration: InputDecoration(
              counterText: "",
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
                fontSize: isMobile ? 16 : 20,
              ),
              prefixIcon: Icon(prefixIcon, color: Colors.blueGrey.shade500),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
