import 'package:evently_app/firebase_services.dart';
import 'package:evently_app/model/categories_model.dart';
import 'package:evently_app/model/event_model.dart';
import 'package:flutter/material.dart';

class EventsProvider with ChangeNotifier {
  List<EventModel> eventsAll = [];
  List<EventModel> eventsDisplay = [];

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
}
