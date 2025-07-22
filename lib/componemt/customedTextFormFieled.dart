import 'package:evently_app/themeapp.dart';
import 'package:flutter/material.dart';

class Customedtextformfieled extends StatelessWidget {
  final String hint;
  final String imageName;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Color? colorBorder;
  final Color? colorHint;
  const Customedtextformfieled({
    super.key,
    required this.hint,
    required this.imageName,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.colorBorder,
    this.colorHint,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorBorder ?? Themeapp.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorBorder ?? Themeapp.grey),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Themeapp.red),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Themeapp.red),
        ),
        hintText: hint,
        hintStyle: Theme.of(
          context,
        ).textTheme.titleMedium!.copyWith(color: colorHint ?? Themeapp.grey),
        prefixIcon: Image.asset(
          "assets/images/$imageName.png",
          height: 24,
          width: 24,
          fit: BoxFit.scaleDown,
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
