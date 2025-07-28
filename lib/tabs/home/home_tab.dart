import 'package:evently_app/Event/event_details_screan.dart';
import 'package:evently_app/firebase_services.dart';
import 'package:evently_app/model/categories_model.dart';
import 'package:evently_app/model/event_model.dart';
import 'package:evently_app/tabs/home/TabBar/tabbar_header.dart';
import 'package:evently_app/tabs/home/event_item.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<EventModel> eventsAll = [];
  List<EventModel> eventsDisplay = [];
  @override
  void initState() {
    getEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabbarHeader(filterEvent: filterEvents),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.only(top: 16),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        EventDetailsScrean(event: eventsDisplay[index]),
                  ),
                );
              },
              child: EventItem(event: eventsDisplay[index]),
            ),
            separatorBuilder: (_, _) => SizedBox(height: 16),
            itemCount: eventsDisplay.length,
          ),
        ),
      ],
    );
  }

  Future<void> getEvents() async {
    eventsAll = await FirebaseServices.getEvents();
    eventsDisplay = eventsAll;
    setState(() {});
  }

  void filterEvents(CategoriesModel? category) {
    if (category == null) {
      eventsDisplay = eventsAll;
    } else {
      eventsDisplay = eventsAll
          .where((event) => event.category == category)
          .toList();
    }
    setState(() {});
  }
}
