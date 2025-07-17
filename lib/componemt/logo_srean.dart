import 'package:flutter/material.dart';

class LogoSrean extends StatelessWidget {
  const LogoSrean({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/images/splash_logo.png",
        width: 136,
        height: 186,
        fit: BoxFit.fill,
      ),
    );
  }
}
