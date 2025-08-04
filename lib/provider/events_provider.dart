import 'package:evently_app/firebase_services.dart';
import 'package:evently_app/model/categories_model.dart';
import 'package:evently_app/model/event_model.dart';
import 'package:flutter/material.dart';

class EventsProvider with ChangeNotifier {
  List<EventModel> eventsAll = [];
  List<EventModel> eventsDisplay = [];
  List<EventModel> favouriteEvents = [];
  List<EventModel> allFavouriteEvents = [];

  Future<void> getEvents() async {
    eventsAll = await FirebaseServices.getEvents();
    eventsDisplay = eventsAll;
    notifyListeners();
  }

  void filterEvents(CategoriesModel? category) {
    if (category == null) {
      eventsDisplay = eventsAll;
    } else {
      eventsDisplay = eventsAll
          .where((event) => event.category == category)
          .toList();
    }
    notifyListeners();
  }

  void filterFavouriteEvents(List<String> favouritesId) {
    allFavouriteEvents = eventsAll
        .where((event) => favouritesId.contains(event.id))
        .toList();
    favouriteEvents = allFavouriteEvents;
    notifyListeners();
  }

  void searchFavoriteEvents(String qurey) {
    if (qurey.isEmpty) {
      favouriteEvents = allFavouriteEvents;
    }
    favouriteEvents = allFavouriteEvents
        .where(
          (event) =>
              event.title.toLowerCase().contains(qurey) ||
              event.title.toUpperCase().contains(qurey),
        )
        .toList();
    notifyListeners();
  }
}
