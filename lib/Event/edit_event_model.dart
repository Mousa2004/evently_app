import 'package:evently_app/componemt/customedTextFormFieled.dart';
import 'package:evently_app/componemt/customedbutton.dart';
import 'package:evently_app/firebase_services.dart';
import 'package:evently_app/model/categories_model.dart';
import 'package:evently_app/model/event_model.dart';
import 'package:evently_app/tabs/home/TabBar/tabbar_item.dart';
import 'package:evently_app/themeapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class EditEventModel extends StatefulWidget {
  final EventModel event;

  const EditEventModel({super.key, required this.event});

  @override
  State<EditEventModel> createState() => _EditEventModelState();
}

class _EditEventModelState extends State<EditEventModel> {
  int currentIndex = 0;
  CategoriesModel selectCategory = CategoriesModel.categories.first;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  DateTime? selectData;
  TimeOfDay? selectTime;
  DateFormat dateFormat = DateFormat('d/M/yyyy');

  @override
  void initState() {
    titleController.text = widget.event.title;
    descriptionController.text = widget.event.description;
    selectData = widget.event.dateTime;
    selectTime = TimeOfDay.fromDateTime(widget.event.dateTime);
    selectCategory = widget.event.category;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Event")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                "assets/images/${selectCategory.imageName}.png",
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

                onTap: (index) {
                  currentIndex = index;
                  selectCategory = CategoriesModel.categories[currentIndex];
                  setState(() {});
                },

                tabs: CategoriesModel.categories
                    .map(
                      (Category) => TabbarItem(
                        imageIcon: Category.imageIcon,
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
            child: Form(
              key: formstate,
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
                    colorHint: Themeapp.grey,
                    imageName: "title_edit",
                    controller: titleController,
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
                    colorHint: Themeapp.grey,
                    imageName: "title_edit",
                    controller: descriptionController,
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
                          if (data != null) {
                            selectData = data;
                            setState(() {});
                          }
                        },
                        child: Text(
                          selectData == null
                              ? "Choose Data"
                              : dateFormat.format(selectData!),
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
                          if (time != null) {
                            selectTime = time;
                            setState(() {});
                          }
                        },
                        child: Text(
                          selectTime == null
                              ? "Choose Time"
                              : selectTime!.format(context),
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
                  Customedbutton(
                    name: "Edit Event",
                    onPressed: () {
                      editEvent();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void editEvent() {
    if (formstate.currentState!.validate() &&
        selectData != null &&
        selectTime != null) {
      DateTime dateTime = DateTime(
        selectData!.year,
        selectData!.month,
        selectData!.day,
        selectTime!.hour,
        selectTime!.minute,
      );
      EventModel event = EventModel(
        id: widget.event.id,
        category: selectCategory,
        title: titleController.text,
        description: descriptionController.text,
        dateTime: dateTime,
      );
      FirebaseServices.editEvent(event).then((_) {
        Navigator.of(context).pop();
      });
    }
  }
}
