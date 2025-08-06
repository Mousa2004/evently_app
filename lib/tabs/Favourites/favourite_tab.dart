import 'package:evently_app/Event/event_details_screan.dart';
import 'package:evently_app/componemt/customedTextFormFieled.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/provider/events_provider.dart';
import 'package:evently_app/provider/users_provider.dart';
import 'package:evently_app/tabs/home/event_item.dart';
import 'package:evently_app/themeapp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteTab extends StatefulWidget {
  const FavouriteTab({super.key});

  @override
  State<FavouriteTab> createState() => _FavouriteTabState();
}

class _FavouriteTabState extends State<FavouriteTab> {
  late EventsProvider eventsProvider;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      List<String> favouriteEventsId = Provider.of<UsersProvider>(
        context,
        listen: false,
      ).currentUser!.favouritesEventsIds;
      eventsProvider.filterFavouriteEvents(favouriteEventsId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    eventsProvider = Provider.of<EventsProvider>(context);
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Customedtextformfieled(
              hint: appLocalizations.searchforEvent,
              imageName: "search",
              colorBorder: Themeapp.primary,
              colorHint: Themeapp.primary,
              onChanged: eventsProvider.searchFavoriteEvents,
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(top: 16),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EventDetailsScrean(
                        event: eventsProvider.favouriteEvents[index],
                      ),
                    ),
                  );
                },
                child: EventItem(event: eventsProvider.favouriteEvents[index]),
              ),
              separatorBuilder: (_, _) => SizedBox(height: 16),
              itemCount: eventsProvider.favouriteEvents.length,
            ),
          ),
        ],
      ),
    );
  }
}
