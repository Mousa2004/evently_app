import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemimageTab extends StatelessWidget {
  final String imageName;
  const ItemimageTab({super.key, required this.imageName});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/$imageName.svg",
      height: 24.h,
      width: 24.w,
      fit: BoxFit.scaleDown,
    );
  }
}
