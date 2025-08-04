import 'package:evently_app/model/user_model.dart';
import 'package:flutter/material.dart';

class UsersProvider with ChangeNotifier {
  UserModel? currentUser;
  void updateCurrentUser(UserModel? user) {
    currentUser = user;
    notifyListeners();
  }
}
