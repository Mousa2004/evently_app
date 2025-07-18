import 'package:evently_app/auth/login_screan.dart';
import 'package:evently_app/tabs/home/home_tab.dart';
import 'package:evently_app/tabs/interaction/interaction_tab.dart';
import 'package:evently_app/tabs/itemImage_tab.dart';
import 'package:evently_app/tabs/map/map_tab.dart';
import 'package:evently_app/tabs/profile/profile_tab.dart';
import 'package:evently_app/themeapp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScrean extends StatefulWidget {
  static const String routName = "/home";
  const HomeScrean({super.key});

  @override
  State<HomeScrean> createState() => _HomeScreanState();
}

class _HomeScreanState extends State<HomeScrean> {
  int currentIndex = 0;
  List<Widget> tabs = [HomeTab(), MapTab(), InteractionTab(), ProfileTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themeapp.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        items: [
          BottomNavigationBarItem(
            icon: ItemimageTab(imageName: "home"),
            activeIcon: ItemimageTab(imageName: "home_active"),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: ItemimageTab(imageName: "map"),
            activeIcon: ItemimageTab(imageName: "map_active"),
            label: "Map",
          ),
          BottomNavigationBarItem(
            icon: ItemimageTab(imageName: "heart"),
            activeIcon: ItemimageTab(imageName: "heart_active"),
            label: "Love",
          ),

          BottomNavigationBarItem(
            icon: ItemimageTab(imageName: "profile"),
            activeIcon: ItemimageTab(imageName: "profile_active"),
            label: "Profile",
          ),
        ],
      ),
      body: tabs[currentIndex],
    );
  }
}
