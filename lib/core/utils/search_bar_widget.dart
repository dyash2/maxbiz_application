import 'dart:async';
import 'package:flutter/material.dart';
import 'package:maxbazaar/core/themes.dart';

class SearchBarWidget extends StatefulWidget {
  final List<String> suggestions;
  final ValueChanged<String>? onChanged;

  const SearchBarWidget({
    super.key,
    this.suggestions = const ['" Food "', '"Restaurants"'],
    this.onChanged,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late final PageController _pageController;
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // auto scroll every 2 seconds
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_pageController.hasClients) {
        _currentIndex = (_currentIndex + 1) % widget.suggestions.length;
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: AppFonts.lexendRegular.copyWith(
        color: Colors.black,
        letterSpacing: 1,
        fontSize: 16,
      ),
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hint: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Search for ",
              style: AppFonts.lexendBold.copyWith(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: SizedBox(
                height: 20,
                width: 100,
                child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.suggestions.length,
                  itemBuilder: (context, index) {
                    return Text(
                      widget.suggestions[index],
                      style: AppFonts.pacifico.copyWith(
                        color: AppColors.textSecondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        overflow: TextOverflow.visible
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        prefixIcon: Icon(Icons.search, color: Colors.orange.shade300),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
