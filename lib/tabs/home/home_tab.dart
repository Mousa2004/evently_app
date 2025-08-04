import 'package:evently_app/Event/event_details_screan.dart';
import 'package:evently_app/provider/events_provider.dart';
import 'package:evently_app/tabs/home/TabBar/tabbar_header.dart';
import 'package:evently_app/tabs/home/event_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    EventsProvider eventsProvider = Provider.of<EventsProvider>(context);
    return Column(
      children: [
        TabbarHeader(),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.only(top: 16),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EventDetailsScrean(
                      event: eventsProvider.eventsDisplay[index],
                    ),
                  ),
                );
              },
              child: EventItem(event: eventsProvider.eventsDisplay[index]),
            ),
            separatorBuilder: (_, _) => SizedBox(height: 16),
            itemCount: eventsProvider.eventsDisplay.length,
          ),
        ),
      ],
    );
  }
}
