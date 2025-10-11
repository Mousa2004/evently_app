import 'package:evently_app/themeapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwitchItem extends StatelessWidget {
  final String name;
  final String imageName1;
  final String imageName2;
  const SwitchItem({
    super.key,
    required this.name,
    required this.imageName1,
    required this.imageName2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Themeapp.primary, width: 2),
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Themeapp.primary),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Image.asset(
                  "assets/images/$imageName1.png",
                  height: 21.h,
                  width: 21.w,
                  fit: BoxFit.scaleDown,
                ),
              ),
              SizedBox(width: 20.w),
              Image.asset(
                "assets/images/$imageName2.png",
                height: 21.h,
                width: 21.w,
                fit: BoxFit.scaleDown,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
