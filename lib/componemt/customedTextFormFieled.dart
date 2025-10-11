import 'package:evently_app/provider/settingtheme_provider.dart';
import 'package:evently_app/themeapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Customedtextformfieled extends StatelessWidget {
  final String hint;
  final String imageName;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Color? colorBorder;
  final Color? colorHint;
  final void Function(String)? onChanged;
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
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    SettingthemeProvider settingthemeProvider =
        Provider.of<SettingthemeProvider>(context);
    return TextFormField(
      style: settingthemeProvider.isDark
          ? Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(color: Themeapp.white)
          : null,
      cursorColor: settingthemeProvider.isDark ? Themeapp.white : null,

      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            color: settingthemeProvider.isDark
                ? Themeapp.primary
                : colorBorder ?? Themeapp.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            color: settingthemeProvider.isDark
                ? Themeapp.primary
                : colorBorder ?? Themeapp.grey,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: Themeapp.red),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: Themeapp.red),
        ),
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
          color: settingthemeProvider.isDark
              ? Themeapp.white
              : colorHint ?? Themeapp.grey,
        ),
        prefixIcon: imageName.isNotEmpty
            ? Image.asset(
                "assets/images/$imageName.png",
                color: settingthemeProvider.isDark ? Themeapp.white : null,
                height: 24.h,
                width: 24.w,
                fit: BoxFit.scaleDown,
              )
            : SizedBox(width: 0.w),
        suffixIcon: suffixIcon,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTapOutside: (_) => FocusManager.instance.primaryFocus!.unfocus(),
    );
  }
}
