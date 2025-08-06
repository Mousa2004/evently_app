import 'package:flutter/material.dart';

class SettinglocalizaionProvider with ChangeNotifier {
  String language = "en";
  void changeLanguage(String langCode) {
    language = langCode;
    notifyListeners();
  }
}
