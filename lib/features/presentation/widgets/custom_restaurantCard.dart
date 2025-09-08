import 'package:flutter/material.dart';
import 'package:maxbazaar/core/themes.dart';

class RestaurantCard extends StatelessWidget {
  final String name;
  final String description;
  final double rating;
  final String location;
  final String image;
  final bool isVeg;

  const RestaurantCard({
    super.key,
    required this.name,
    required this.description,
    required this.rating,
    required this.location,
    required this.image,
    this.isVeg = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          // 🖼 Image with aspect ratio
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 100,
                child: AspectRatio(
                  aspectRatio: 1, // Square ratio
                  child: Image.asset(image, fit: BoxFit.cover),
                ),
              ),
            ),
          ),

          // 📝 Info section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppFonts.lexendBold.copyWith(fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                  ),
                  const SizedBox(height: 4),

                  // ⭐ Rating + Veg/Non-Veg
                  Row(
                    children: [
                      Icon(Icons.star, size: 16, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text(
                        rating.toStringAsFixed(1),
                        style: AppFonts.lexendRegular.copyWith(fontSize: 16),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.circle,
                        size: 12,
                        color: isVeg ? Colors.green : Colors.red,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  Text(
                    description,
                    style: AppFonts.lexendRegular.copyWith(
                      fontSize: 13,
                      color: Colors.grey[700],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                  ),
                  const SizedBox(height: 6),

                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 14,

                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: AppFonts.lexendRegular.copyWith(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
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
