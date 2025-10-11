import 'package:evently_app/Event/create_event_model.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/tabs/home/home_tab.dart';
import 'package:evently_app/tabs/Favourites/favourite_tab.dart';
import 'package:evently_app/tabs/itemImage_tab.dart';
import 'package:evently_app/tabs/map/map_tab.dart';
import 'package:evently_app/tabs/profile/profile_tab.dart';
import 'package:evently_app/themeapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScrean extends StatefulWidget {
  static const String routName = "/home";
  const HomeScrean({super.key});

  @override
  State<HomeScrean> createState() => _HomeScreanState();
}

class _HomeScreanState extends State<HomeScrean> {
  int currentIndex = 0;
  List<Widget> tabs = [HomeTab(), MapTab(), FavouriteTab(), ProfileTab()];
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(CreateEventModel.routName);
        },
        child: Icon(Icons.add, color: Themeapp.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
        selectedItemColor: Themeapp.white,
        unselectedItemColor: Themeapp.white,
        selectedLabelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
        items: [
          BottomNavigationBarItem(
            icon: ItemimageTab(imageName: "home"),
            activeIcon: ItemimageTab(imageName: "home_active"),
            label: appLocalizations.home,
          ),
          BottomNavigationBarItem(
            icon: ItemimageTab(imageName: "map"),
            activeIcon: ItemimageTab(imageName: "map_active"),
            label: appLocalizations.map,
          ),
          BottomNavigationBarItem(
            icon: ItemimageTab(imageName: "heart"),
            activeIcon: ItemimageTab(imageName: "heart_active"),
            label: appLocalizations.love,
          ),

          BottomNavigationBarItem(
            icon: ItemimageTab(imageName: "profile"),
            activeIcon: ItemimageTab(imageName: "profile_active"),
            label: appLocalizations.profile,
          ),
        ],
      ),
      body: tabs[currentIndex],
    );
  }
}
