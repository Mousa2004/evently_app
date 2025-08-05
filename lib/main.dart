import 'package:evently_app/Event/create_event_model.dart';
import 'package:evently_app/auth/login_screan.dart';
import 'package:evently_app/auth/register_screan.dart';
import 'package:evently_app/home_screan.dart';
import 'package:evently_app/onboarding/onboarding.dart';
import 'package:evently_app/provider/events_provider.dart';
import 'package:evently_app/provider/settingtheme_provider.dart';
import 'package:evently_app/provider/users_provider.dart';
import 'package:evently_app/themeapp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final sharedPref = await SharedPreferences.getInstance();
  bool onboard = sharedPref.getBool("onboarding") ?? false;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UsersProvider()),
        ChangeNotifierProvider(create: (context) => SettingthemeProvider()),
        ChangeNotifierProvider(
          create: (context) => EventsProvider()..getEvents(),
        ),
      ],
      child: MyApp(onboard: onboard),
    ),
  );
}

class MyApp extends StatefulWidget {
  final bool onboard;
  const MyApp({super.key, required this.onboard});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('=========================User is currently signed out!');
      } else {
        print('=========================User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SettingthemeProvider settingthemeProvider =
        Provider.of<SettingthemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: widget.onboard
          ? ((FirebaseAuth.instance.currentUser != null)
                ? HomeScrean.routName
                : LoginScrean.routName)
          : Onboarding.routName,
      routes: {
        HomeScrean.routName: (_) => HomeScrean(),
        Onboarding.routName: (_) => Onboarding(),
        LoginScrean.routName: (_) => LoginScrean(),
        RegisterScrean.routName: (_) => RegisterScrean(),
        CreateEventModel.routName: (_) => CreateEventModel(),
      },
      theme: Themeapp.themeAppLight,
      darkTheme: Themeapp.themeAppDark,
      themeMode: settingthemeProvider.themeMode,
    );
  }
}
