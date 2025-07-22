import 'package:evently_app/tabs/home/TabBar/tabbar_header.dart';
import 'package:evently_app/tabs/home/event_item.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    List event = [
      {"imageName": "birthday_event", "text": "This is a Birthday Party"},
      {"imageName": "meeting_event", "text": "This is a Meeting Party"},
      {"imageName": "holiday_event", "text": "This is a Holiday Party"},
      {"imageName": "exhibition_event", "text": "This is a Exhibition Party"},
      {"imageName": "sport_event", "text": "This is a Sport Party"},
    ];
    return Column(
      children: [
        TabbarHeader(),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.only(top: 16),
            itemBuilder: (context, index) => EventItem(
              imageName: event[index]['imageName'],
              text: event[index]['text'],
            ),
            separatorBuilder: (_, _) => SizedBox(height: 16),
            itemCount: event.length,
          ),
        ),
      ],
    );
  }
}
