import 'package:evently_app/componemt/customedTextFormFieled.dart';
import 'package:evently_app/themeapp.dart';
import 'package:flutter/material.dart';

class FavouriteTab extends StatelessWidget {
  const FavouriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Customedtextformfieled(
              hint: "Search for Event",
              imageName: "search",
              colorBorder: Themeapp.primary,
              colorHint: Themeapp.primary,
            ),
          ),
        ],
      ),
    );
  }
}
