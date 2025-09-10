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
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🖼 Image with aspect ratio
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
              child: AspectRatio(
                aspectRatio: 9 / 12,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(image, fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          // 📝 Info section
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text should expand and take available space
                      Expanded(
                        child: Text(
                          name,
                          style: AppFonts.lexendBold.copyWith(fontSize: 18),
                          maxLines: 2,
                          overflow: TextOverflow
                              .ellipsis, // use ellipsis instead of visible
                        ),
                      ),
                      const SizedBox(width: 2),
                      // Icons stacked vertically
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Icon(Icons.favorite, color: Colors.redAccent),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // ⭐ Rating + Veg/Non-Veg
                  Row(
                    children: [
                      Image.asset("assets/icons/star_rating.png", scale: 5),
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
