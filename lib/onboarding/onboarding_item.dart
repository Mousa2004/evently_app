import 'package:evently_app/themeapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingItem extends StatelessWidget {
  final EdgeInsetsGeometry? margin;

  final TextDirection? textDirection;
  const OnboardingItem({super.key, this.margin, this.textDirection});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: 37.h,
      width: 37.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: Themeapp.primary),
      ),
      child: Icon(Icons.arrow_back, textDirection: textDirection),
    );
  }
}
