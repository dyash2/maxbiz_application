import 'package:flutter/material.dart';
import 'package:maxbazaar/core/themes.dart';
import 'package:maxbazaar/features/home/presentation/widgets/carousel_view_widget.dart';
import 'package:maxbazaar/features/home/presentation/widgets/components/sliverAppBar_delegate.dart';
import 'package:maxbazaar/features/home/presentation/widgets/gradient_background_widget.dart';
import 'package:maxbazaar/features/home/presentation/widgets/header_widget.dart';
import 'package:maxbazaar/features/home/presentation/widgets/restaurant_card_widget.dart';
import 'package:maxbazaar/core/utils/widgets/search_bar_widget.dart';
import 'package:maxbazaar/features/home/presentation/widgets/filter_chip_row.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: CustomScrollView(
            slivers: [
              // (hides on scroll)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: HeaderPage(),
                ),
              ),

              // bar (pinned so it always shows)
              SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: SliverAppBarDelegate(
                  minHeight: 60,
                  maxHeight: 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SearchBarWidget(),
                  ),
                ),
              ),

              // (hides on scroll)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CarouselViewComponent(
                    imageList: [
                      'assets/icons/food1.jpg',
                      'assets/icons/food2.jpg',
                    ],
                  ),
                ),
              ),

              // chips (pinned so they show on scroll)
              SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: SliverAppBarDelegate(
                  minHeight: 60,
                  maxHeight: 60,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      top: 8.0,
                      bottom: 8.0,
                    ),
                    child: FilterChipsRow(),
                  ),
                ),
              ),

              //  text (hides on scroll)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 12,
                  ),
                  child: Text(
                    "Explore New Restaurants Near You!",
                    style: AppFonts.lexendBold.copyWith(fontSize: 14),
                  ),
                ),
              ),

              // list (scrolls)
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final restaurants = [
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
                  ];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4,
                    ),
                    child: restaurants[index % restaurants.length],
                  );
                }, childCount: 10),
              ),
            ],
          ),

          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            iconSize: 28,
            selectedItemColor: AppColors.primaryColor,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.fastfood_outlined),
                label: 'Restaurant',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Choose Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'My Cart',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
