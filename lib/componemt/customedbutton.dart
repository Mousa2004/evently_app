import 'package:evently_app/themeapp.dart';
import 'package:flutter/material.dart';

class Customedbutton extends StatelessWidget {
  final void Function() onPressed;
  final String name;
  const Customedbutton({
    super.key,
    required this.name,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        color: Themeapp.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: EdgeInsets.symmetric(vertical: 16),
        onPressed: onPressed,
        child: Text(
          name,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w500,
            color: Themeapp.white,
          ),
        ),
      ),
    );
  }
}
