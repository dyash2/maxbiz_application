import 'package:flutter/material.dart';
import 'package:maxbazaar/core/themes.dart';
import 'package:maxbazaar/features/presentation/widgets/custom_restaurantCard.dart';
import 'package:maxbazaar/features/presentation/widgets/custom_searchbar.dart';
import 'package:maxbazaar/features/presentation/widgets/filter_chip_row.dart';
import 'package:maxbazaar/features/presentation/widgets/gradient_background.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            CustomSearchBar(),
            const SizedBox(height: 16),

            // Carousel Promo Banner
            SizedBox(
              height: 180,
              child: CarouselView(
                scrollDirection: Axis.horizontal,
                itemExtent: double.infinity,
                children: List.generate(3, (index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage('assets/icons/food1.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: const FilterChipsRow()),
            const SizedBox(height: 24),
            Text(
              "Explore Restaurants Near You",
              style: AppFonts.lexendBold.copyWith(fontSize: 18),
            ),

            RestaurantCard(
              name: "The Fella's Restaurant & Cafe",
              description: "Chinese • Fast Food • Maharashtra",
              rating: 4.5,
              location: "Mumbai - 02-07 Mins",
              image: 'assets/fellas.jpg',
              isVeg: false,
            ),
            RestaurantCard(
              name: "Fresh & Fast Food",
              description: "Quick Bites • Snacks",
              rating: 4.0,
              location: "Mumbai - 05-10 Mins",
              image: 'assets/fresh_fast.jpg',
              isVeg: true,
            ),
            RestaurantCard(
              name: "The Fella's Restaurant & Cafe",
              description: "Chinese • Fast Food • Maharashtra",
              rating: 4.5,
              location: "Mumbai - 02-07 Mins",
              image: 'assets/fellas.jpg',
              isVeg: false,
            ),
            RestaurantCard(
              name: "Fresh & Fast Food",
              description: "Quick Bites • Snacks",
              rating: 4.0,
              location: "Mumbai - 05-10 Mins",
              image: 'assets/fresh_fast.jpg',
              isVeg: true,
            ),
          ],
        ),
      ),
    );
  }
}
