import 'package:flutter/material.dart';
import 'package:maxbazaar/core/themes.dart';

class FilterChipOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final String? iconImage;

  const FilterChipOption({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.iconImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.greenAccent.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconImage != null) ...[
              Image.asset(
                iconImage.toString(),
                scale: 3,
                color: label == "Veg" ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: AppFonts.lexendBold.copyWith(
                color: selected ? Colors.black : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (selected) ...[
              const SizedBox(width: 6),
              const Icon(Icons.close, size: 14, color: Colors.black),
            ],
          ],
        ),
      ),
    );
  }
}
