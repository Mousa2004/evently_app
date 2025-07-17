import 'package:evently_app/themeapp.dart';
import 'package:flutter/material.dart';

class OnboardingItem extends StatelessWidget {
  final EdgeInsetsGeometry? margin;

  final TextDirection? textDirection;
  const OnboardingItem({super.key, this.margin, this.textDirection});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: 37,
      width: 37,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Themeapp.primary),
      ),
      child: Icon(Icons.arrow_back, textDirection: textDirection),
    );
  }
}
