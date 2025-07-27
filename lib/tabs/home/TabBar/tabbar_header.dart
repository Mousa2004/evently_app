import 'package:evently_app/model/categories_model.dart';
import 'package:evently_app/tabs/home/TabBar/tabbar_item.dart';
import 'package:evently_app/themeapp.dart';
import 'package:flutter/material.dart';

class TabbarHeader extends StatefulWidget {
  const TabbarHeader({super.key});

  @override
  State<TabbarHeader> createState() => _TabbarHeaderState();
}

class _TabbarHeaderState extends State<TabbarHeader> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Themeapp.primary,
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
                "Welcome Back ✨",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                "User Name",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              DefaultTabController(
                length: CategoriesModel.categories.length + 1,
                child: TabBar(
                  onTap: (index) {
                    if (currentIndex == index) return;
                    currentIndex = index;
                    setState(() {});
                  },
                  indicatorColor: Themeapp.transparent,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  labelPadding: EdgeInsets.only(right: 10),
                  tabs: [
                    TabbarItem(
                      imageIcon: "all",
                      text: "All",
                      isSelect: currentIndex == 0,

                      selectColor: Themeapp.primary,
                      unselectColor: Themeapp.white,
                    ),
                    ...CategoriesModel.categories.map(
                      (category) => TabbarItem(
                        imageIcon: category.imageIcon,
                        text: category.name,
                        isSelect:
                            currentIndex ==
                            CategoriesModel.categories.indexOf(category) + 1,

                        selectColor: Themeapp.primary,
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
