import 'package:evently_app/Event/edit_event_model.dart';
import 'package:evently_app/model/event_model.dart';
import 'package:evently_app/themeapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class EventDetailsScrean extends StatefulWidget {
  final EventModel event;
  const EventDetailsScrean({super.key, required this.event});

  @override
  State<EventDetailsScrean> createState() => _EventDetailsScreanState();
}

class _EventDetailsScreanState extends State<EventDetailsScrean> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Detals"),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditEventModel(event: widget.event),
                ),
              );
            },
            child: Image.asset(
              "assets/images/edit_icon.png",
              height: 24,
              width: 24,
              fit: BoxFit.scaleDown,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete, color: Themeapp.red, size: 24),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                "assets/images/${widget.event.category.imageName}.png",
                height: MediaQuery.sizeOf(context).height * 0.23,
                width: MediaQuery.sizeOf(context).width,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 16),
            Text(
              widget.event.title,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Themeapp.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Themeapp.primary),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Themeapp.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      "assets/images/calender.png",
                      height: 24,
                      width: 24,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('d MMMM yyyy').format(widget.event.dateTime),
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: Themeapp.primary),
                      ),
                      SizedBox(height: 4),
                      Text(
                        DateFormat('h:mm a').format(widget.event.dateTime),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Themeapp.primary),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Themeapp.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/location.svg",
                      height: 24,
                      width: 24,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    "Cairo , Egypt",
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(color: Themeapp.primary),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.40,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Themeapp.primary),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text("Description", style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 8),
            Text(
              widget.event.description,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
