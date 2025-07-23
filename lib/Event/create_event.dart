import 'package:evently_app/componemt/customedTextFormFieled.dart';
import 'package:evently_app/componemt/customedbutton.dart';
import 'package:evently_app/model/categories_model.dart';
import 'package:evently_app/tabs/home/TabBar/tabbar_item.dart';
import 'package:evently_app/themeapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CreateEvent extends StatefulWidget {
  static const String routName = "/create_event";
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Event")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                "assets/images/sport_event.png",
                height: MediaQuery.sizeOf(context).height * 0.23,
                width: MediaQuery.sizeOf(context).width,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: DefaultTabController(
              length: CategoriesModel.categories.length,
              child: TabBar(
                labelPadding: EdgeInsets.only(right: 10),
                isScrollable: true,
                indicatorColor: Themeapp.transparent,
                dividerColor: Themeapp.transparent,
                tabAlignment: TabAlignment.start,

                onTap: (value) {
                  currentIndex = value;
                  setState(() {});
                },

                tabs: CategoriesModel.categories
                    .map(
                      (Category) => TabbarItem(
                        imageName: Category.imageName,
                        text: Category.name,
                        isSelect:
                            currentIndex ==
                            CategoriesModel.categories.indexOf(Category),
                        selectColor: Themeapp.white,
                        unselectColor: Themeapp.primary,
                        colorBorder: Themeapp.primary,
                        selectBackgroundColor: Themeapp.primary,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Title",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                SizedBox(height: 8),
                Customedtextformfieled(
                  hint: "Event Title",
                  imageName: "title_edit",
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Description",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                SizedBox(height: 8),
                Customedtextformfieled(
                  hint: "Event Description",
                  imageName: "",
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/data.svg",
                      height: 24,
                      width: 24,
                      fit: BoxFit.scaleDown,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Event Data",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () async {
                        DateTime? data = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                        );
                        print(data);
                      },
                      child: Text(
                        "Choose Data",
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: Themeapp.primary),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/time.svg",
                      height: 24,
                      width: 24,
                      fit: BoxFit.scaleDown,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Event Time",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () async {
                        TimeOfDay? time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        print(time);
                      },
                      child: Text(
                        "Choose Time",
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: Themeapp.primary),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Location",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                SizedBox(height: 8),
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
                        child: SvgPicture.asset("assets/icons/location.svg"),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Choose Event Location",
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: Themeapp.primary),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Customedbutton(name: "Add Event", onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
