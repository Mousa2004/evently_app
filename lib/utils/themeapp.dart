import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Themeapp {
  static const Color primary = Color(0xFF5669FF);
  static const Color white = Color(0xFFF2FEFF);
  static const Color backgroundDark = Color(0xFF101127);
  static const Color black = Color(0xFF1C1C1C);
  static const Color red = Color(0xFFFF5659);
  static const Color grey = Color(0xFF7B7B7B);
  static const Color green = Colors.green;
  static const Color transparent = Colors.transparent;
  static ThemeData themeAppLight = ThemeData(
    scaffoldBackgroundColor: white,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        color: primary,
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
      ),
      centerTitle: true,
      iconTheme: IconThemeData(color: primary),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: primary,
      ),
      titleMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: black,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: white,
      ),
      headlineSmall: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        color: white,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: primary,
      type: BottomNavigationBarType.fixed,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      shape: CircleBorder(
        side: BorderSide(color: white, width: 5.w),
      ),
    ),
  );

  static ThemeData themeAppDark = ThemeData(
    scaffoldBackgroundColor: backgroundDark,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        color: primary,
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
      ),
      backgroundColor: backgroundDark,
      centerTitle: true,
      iconTheme: IconThemeData(color: primary),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: primary,
      ),
      titleMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: black,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: white,
      ),
      headlineSmall: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        color: white,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: backgroundDark,
      type: BottomNavigationBarType.fixed,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: backgroundDark,
      shape: CircleBorder(
        side: BorderSide(color: white, width: 5.w),
      ),
    ),
  );
}
