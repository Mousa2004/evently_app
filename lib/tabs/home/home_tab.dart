import 'package:evently_app/Event/event_details_screan.dart';
import 'package:evently_app/provider/events_provider.dart';
import 'package:evently_app/tabs/home/TabBar/tabbar_header.dart';
import 'package:evently_app/tabs/home/event_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool isLoadig = true;
  @override
  void initState() {
    isLoadig = true;
    setState(() {});
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<EventsProvider>(context, listen: false);
      provider.getEvents();
    });
    isLoadig = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    EventsProvider eventsProvider = Provider.of<EventsProvider>(context);
    return isLoadig
        ? Center(child: CircularProgressIndicator())
        : Column(
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
                    child: EventItem(
                      event: eventsProvider.eventsDisplay[index],
                    ),
                  ),
                  separatorBuilder: (_, _) => SizedBox(height: 16),
                  itemCount: eventsProvider.eventsDisplay.length,
                ),
              ),
            ],
          );
  }
}
