import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/model/categories_model.dart';
import 'package:evently_app/provider/events_provider.dart';
import 'package:evently_app/provider/settingtheme_provider.dart';
import 'package:evently_app/provider/users_provider.dart';
import 'package:evently_app/tabs/home/TabBar/tabbar_item.dart';
import 'package:evently_app/themeapp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabbarHeader extends StatefulWidget {
  const TabbarHeader({super.key});
  @override
  State<TabbarHeader> createState() => _TabbarHeaderState();
}

class _TabbarHeaderState extends State<TabbarHeader> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    SettingthemeProvider settingthemeProvider =
        Provider.of<SettingthemeProvider>(context);
    EventsProvider eventsProvider = Provider.of<EventsProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: settingthemeProvider.isDark
            ? Themeapp.backgroundDark
            : Themeapp.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${appLocalizations.welcomeback} ✨",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                Provider.of<UsersProvider>(context).currentUser!.name,

                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              DefaultTabController(
                length: CategoriesModel.categories.length + 1,
                child: TabBar(
                  onTap: (index) {
                    if (currentIndex == index) return;
                    currentIndex = index;
                    CategoriesModel? selectCategry = currentIndex == 0
                        ? null
                        : CategoriesModel.categories[currentIndex - 1];
                    eventsProvider.filterEvents(selectCategry);
                    setState(() {});
                  },
                  dividerColor: Themeapp.transparent,
                  indicatorColor: Themeapp.transparent,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  labelPadding: EdgeInsets.only(right: 10),
                  tabs: [
                    TabbarItem(
                      imageIcon: "all",
                      text: "All",
                      isSelect: currentIndex == 0,

                      selectColor: settingthemeProvider.isDark
                          ? Themeapp.white
                          : Themeapp.primary,
                      unselectColor: Themeapp.white,
                    ),
                    ...CategoriesModel.categories.map(
                      (category) => TabbarItem(
                        imageIcon: category.imageIcon,
                        text: category.name,
                        isSelect:
                            currentIndex ==
                            CategoriesModel.categories.indexOf(category) + 1,

                        selectColor: settingthemeProvider.isDark
                            ? Themeapp.white
                            : Themeapp.primary,
                        unselectColor: Themeapp.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
