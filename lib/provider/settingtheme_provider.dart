import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingthemeProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDark => themeMode == ThemeMode.dark;

  SettingthemeProvider() {
    loadTheme();
  }
  void changeTheme(ThemeMode theme) async {
    themeMode = theme;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      "themeMode",
      themeMode == ThemeMode.dark ? "dark" : "light",
    );
  }

  void loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedTheme = prefs.getString("themeMode");

    if (savedTheme == "dark") {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    notifyListeners();
  }
}
