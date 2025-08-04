import 'package:evently_app/firebase_services.dart';
import 'package:evently_app/model/user_model.dart';
import 'package:flutter/material.dart';

class UsersProvider with ChangeNotifier {
  UserModel? currentUser;
  void updateCurrentUser(UserModel? user) {
    currentUser = user;
    notifyListeners();
  }

  bool checkIsFavoritEvent(String eventId) {
    return currentUser!.favouritesEventsIds.contains(eventId);
  }

  void addEventToFavourite(String eventId) {
    FirebaseServices.addEventToFavourites(eventId);
    currentUser!.favouritesEventsIds.add(eventId);
    notifyListeners();
  }

  void removeEventFromFavourite(String eventId) {
    FirebaseServices.deleteEventToFavourites(eventId);
    currentUser!.favouritesEventsIds.remove(eventId);
    notifyListeners();
  }
}
