import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/firebase_service/model/categories_model.dart';
import 'package:evently_app/provider/events_provider.dart';
import 'package:evently_app/provider/settingtheme_provider.dart';
import 'package:evently_app/provider/users_provider.dart';
import 'package:evently_app/tabs/home/widget/tabbar_item.dart';
import 'package:evently_app/utils/themeapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TabbarHeader extends StatefulWidget {
  const TabbarHeader({super.key});

  @override
  State<TabbarHeader> createState() => _TabbarHeaderState();
}

class _TabbarHeaderState extends State<TabbarHeader>
    with TickerProviderStateMixin {
  late TabController tabController;

  late List<CategoriesModel> categories;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) return;

    categories = CategoriesModel.categories(context);

    tabController = TabController(length: categories.length + 1, vsync: this);

    _initialized = true;
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final settingthemeProvider = Provider.of<SettingthemeProvider>(context);
    final eventsProvider = Provider.of<EventsProvider>(context);
    final usersProvider = Provider.of<UsersProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: settingthemeProvider.isDark
            ? Themeapp.backgroundDark
            : Themeapp.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.r),
          bottomRight: Radius.circular(16.r),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 👋 Welcome text
              Text(
                "${appLocalizations.welcomeback} ✨",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                usersProvider.currentUser!.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              SizedBox(height: 16.h),

              /// 🔥 TAB BAR
              TabBar(
                controller: tabController,
                isScrollable: true,
                dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                tabAlignment: TabAlignment.start,
                labelPadding: const EdgeInsets.only(right: 10),

                onTap: (index) {
                  final selectedCategory = index == 0
                      ? null
                      : categories[index - 1];

                  eventsProvider.filterEvents(selectedCategory);
                },

                tabs: [
                  /// ALL TAB
                  TabbarItem(
                    imageIcon: "all",
                    text: appLocalizations.all,
                    isSelect: tabController.index == 0,
                    selectColor: settingthemeProvider.isDark
                        ? Themeapp.white
                        : Themeapp.primary,
                    unselectColor: Themeapp.white,
                  ),

                  /// CATEGORIES
                  ...List.generate(categories.length, (index) {
                    final category = categories[index];

                    return TabbarItem(
                      imageIcon: category.imageIcon,
                      text: category.name,
                      isSelect: tabController.index == index + 1,
                      selectColor: settingthemeProvider.isDark
                          ? Themeapp.white
                          : Themeapp.primary,
                      unselectColor: Themeapp.white,
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
