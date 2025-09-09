import 'package:flutter/material.dart';
import 'package:maxbazaar/core/themes.dart';
import 'package:maxbazaar/features/presentation/widgets/carousel_view_widget.dart';
import 'package:maxbazaar/features/presentation/widgets/header_widget.dart';
import 'package:maxbazaar/features/presentation/widgets/restaurant_card_widget.dart';
import 'package:maxbazaar/features/presentation/widgets/search_bar_widget.dart';
import 'package:maxbazaar/features/presentation/widgets/filter_chip_row.dart';
import 'package:maxbazaar/features/presentation/widgets/gradient_background_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: ListView(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 2,
            bottom: 16
          ),
          children: [
            HeaderPage(),
            const SizedBox(height: 2),
            SearchBarWidget(),
            const SizedBox(height: 16),

            CarouselViewComponent(
              imageList: ['assets/icons/food1.jpg', 'assets/icons/food2.jpg'],
            ),

            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: const FilterChipsRow(),
            ),
            const SizedBox(height: 24),
            Text(
              "Explore New Restaurants Near You!",
              style: AppFonts.lexendBold.copyWith(fontSize: 14),
            ),

            RestaurantCard(
              name: "The Fella's Restaurant & Cafe",
              description: "Chinese • Fast Food • Maharashtra",
              rating: 4.5,
              location: "Mumbai - 02-07 Mins",
              image: 'assets/icons/food1.jpg',
              isVeg: false,
            ),
            RestaurantCard(
              name: "Fresh & Fast Food",
              description: "Quick Bites • Snacks",
              rating: 4.0,
              location: "Mumbai - 05-10 Mins",
              image: 'assets/icons/food1.jpg',
              isVeg: true,
            ),
            RestaurantCard(
              name: "The Fella's Restaurant & Cafe",
              description: "Chinese • Fast Food • Maharashtra",
              rating: 4.5,
              location: "Mumbai - 02-07 Mins",
              image: 'assets/icons/food1.jpg',
              isVeg: false,
            ),
            RestaurantCard(
              name: "Fresh & Fast Food",
              description: "Quick Bites • Snacks",
              rating: 4.0,
              location: "Mumbai - 05-10 Mins",
              image: 'assets/icons/food1.jpg',
              isVeg: true,
            ),
          ],
        ),
      ),
    );
  }
}
