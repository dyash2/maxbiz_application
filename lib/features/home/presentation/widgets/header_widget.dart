import 'package:flutter/material.dart';
import 'package:maxbazaar/core/themes.dart';

class HeaderPage extends StatelessWidget {
  const HeaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.location_on_outlined, color: Colors.orange.shade800),
            Text(
              "Malad",
              style: AppFonts.lexendExtraBold.copyWith(
                fontStyle: FontStyle.italic,
                fontSize: 18,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_drop_down, size: 40),
            ),
          ],
        ),
        CircleAvatar(child: Image.asset("assets/images/Profile.png")),
      ],
    );
  }
}
