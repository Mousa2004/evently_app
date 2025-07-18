import 'package:evently_app/tabs/home/TabBar/tabbar_header.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [TabbarHeader()]);
  }
}
