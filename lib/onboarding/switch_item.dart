import 'package:evently_app/themeapp.dart';
import 'package:flutter/material.dart';

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
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Themeapp.primary),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Image.asset(
                  "assets/images/$imageName1.png",
                  height: 21,
                  width: 21,
                  fit: BoxFit.scaleDown,
                ),
              ),
              SizedBox(width: 20),
              Image.asset(
                "assets/images/$imageName2.png",
                height: 21,
                width: 21,
                fit: BoxFit.scaleDown,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
