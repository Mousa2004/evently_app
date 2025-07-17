import 'package:evently_app/home_screan.dart';
import 'package:evently_app/onboarding/onboarding.dart';
import 'package:evently_app/themeapp.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPref = await SharedPreferences.getInstance();
  bool onboard = sharedPref.getBool("onboarding") ?? false;
  runApp(MyApp(onboard: onboard));
}

class MyApp extends StatefulWidget {
  final bool onboard;
  const MyApp({super.key, required this.onboard});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: widget.onboard ? HomeScrean.routName : Onboarding.routName,
      routes: {
        HomeScrean.routName: (_) => HomeScrean(),
        Onboarding.routName: (_) => Onboarding(),
      },
      theme: Themeapp.themeAppLight,
      darkTheme: Themeapp.themeAppDark,
      themeMode: ThemeMode.light,
    );
  }
}
