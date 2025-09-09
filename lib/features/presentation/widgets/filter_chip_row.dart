import 'package:flutter/material.dart';
import 'package:maxbazaar/features/presentation/widgets/filter_chip_option.dart';

class FilterChipsRow extends StatefulWidget {
  const FilterChipsRow({super.key});

  @override
  State<FilterChipsRow> createState() => _FilterChipsRowState();
}

class _FilterChipsRowState extends State<FilterChipsRow> {
  String? selected;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FilterChipOption(
          label: "Veg",
          iconImage: "assets/icons/veg.png",
          selected: selected == "Veg",
          onTap: () {
            setState(() => selected = selected == "Veg" ? null : "Veg");
          },
        ),
        FilterChipOption(
          label: "Non Veg",
          iconImage: "assets/icons/nonveg.png",
          selected: selected == "Non Veg",
          onTap: () {
            setState(() => selected = selected == "Non Veg" ? null : "Non Veg");
          },
        ),
        FilterChipOption(
          label: "Jain",
          selected: selected == "Jain",
          onTap: () {
            setState(() => selected = selected == "Jain" ? null : "Jain");
          },
        ),
      ],
    );
  }
}
