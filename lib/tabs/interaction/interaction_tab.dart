import 'package:evently_app/componemt/customedTextFormFieled.dart';
import 'package:evently_app/tabs/home/event_item.dart';
import 'package:evently_app/themeapp.dart';
import 'package:flutter/material.dart';

class InteractionTab extends StatelessWidget {
  const InteractionTab({super.key});

  @override
  Widget build(BuildContext context) {
    List event = [
      {"imageName": "birthday_event", "text": "This is a Birthday Party"},
      {"imageName": "meeting_event", "text": "This is a Meeting Party"},
      {"imageName": "holiday_event", "text": "This is a Holiday Party"},
      {"imageName": "exhibition_event", "text": "This is a Exhibition Party"},
      {"imageName": "sport_event", "text": "This is a Sport Party"},
    ];
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Customedtextformfieled(
              hint: "Search for Event",
              imageName: "search",
              colorBorder: Themeapp.primary,
              colorHint: Themeapp.primary,
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(top: 0),
              itemBuilder: (context, index) => EventItem(
                imageName: event[index]['imageName'],
                text: event[index]['text'],
              ),
              separatorBuilder: (_, _) => SizedBox(height: 16),
              itemCount: event.length,
            ),
          ),
        ],
      ),
    );
  }
}
