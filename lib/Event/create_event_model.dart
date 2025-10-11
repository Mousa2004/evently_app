import 'package:evently_app/componemt/customedTextFormFieled.dart';
import 'package:evently_app/componemt/customedbutton.dart';
import 'package:evently_app/componemt/utility.dart';
import 'package:evently_app/firebase_services.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/model/categories_model.dart';
import 'package:evently_app/model/event_model.dart';
import 'package:evently_app/provider/events_provider.dart';
import 'package:evently_app/provider/settingtheme_provider.dart';
import 'package:evently_app/tabs/home/TabBar/tabbar_item.dart';
import 'package:evently_app/themeapp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateEventModel extends StatefulWidget {
  static const String routName = "/create_event";
  const CreateEventModel({super.key});

  @override
  State<CreateEventModel> createState() => _CreateEventModelState();
}

class _CreateEventModelState extends State<CreateEventModel> {
  int currentIndex = 0;
  CategoriesModel selectCategory = CategoriesModel.categories.first;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  DateTime? selectData;
  TimeOfDay? selectTime;
  DateFormat dateFormat = DateFormat('d/M/yyyy');
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    SettingthemeProvider settingthemeProvider =
        Provider.of<SettingthemeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.createEvent)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: settingthemeProvider.isDark
                      ? Border.all(color: Themeapp.primary)
                      : null,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    "assets/images/${selectCategory.imageName}.png",
                    height: MediaQuery.sizeOf(context).height * 0.23.h,
                    width: MediaQuery.sizeOf(context).width.w,
                    fit: BoxFit.fill,
                  ),
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
                          selectColor: settingthemeProvider.isDark
                              ? Themeapp.black
                              : Themeapp.white,
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
                        appLocalizations.title,
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(
                              color: settingthemeProvider.isDark
                                  ? Themeapp.white
                                  : null,
                            ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Customedtextformfieled(
                      hint: appLocalizations.eventTitle,
                      imageName: "title_edit",
                      controller: title,
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        appLocalizations.description,
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(
                              color: settingthemeProvider.isDark
                                  ? Themeapp.white
                                  : null,
                            ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Customedtextformfieled(
                      hint: appLocalizations.eventDescription,
                      imageName: "title_edit",
                      controller: description,
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/data.svg",
                          height: 24.h,
                          width: 24.w,
                          fit: BoxFit.scaleDown,
                          colorFilter: settingthemeProvider.isDark
                              ? ColorFilter.mode(
                                  Themeapp.white,
                                  BlendMode.srcIn,
                                )
                              : null,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          appLocalizations.eventData,
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(
                                color: settingthemeProvider.isDark
                                    ? Themeapp.white
                                    : null,
                              ),
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
                                ? appLocalizations.chooseData
                                : dateFormat.format(selectData!),
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(color: Themeapp.primary),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/time.svg",
                          height: 24.h,
                          width: 24.w,
                          fit: BoxFit.scaleDown,
                          colorFilter: settingthemeProvider.isDark
                              ? ColorFilter.mode(
                                  Themeapp.white,
                                  BlendMode.srcIn,
                                )
                              : null,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          appLocalizations.eventTime,

                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(
                                color: settingthemeProvider.isDark
                                    ? Themeapp.white
                                    : null,
                              ),
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
                                ? appLocalizations.chooseTime
                                : selectTime!.format(context),
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(color: Themeapp.primary),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        appLocalizations.location,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    SizedBox(height: 8.h),
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
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/location.svg",
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            appLocalizations.chooseEventLocation,
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(color: Themeapp.primary),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Customedbutton(
                      name: appLocalizations.addEvent,
                      onPressed: () {
                        createEvent();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createEvent() {
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
        userId: FirebaseAuth.instance.currentUser!.uid,
        category: selectCategory,
        title: title.text,
        description: description.text,
        dateTime: dateTime,
      );
      FirebaseServices.createEvent(event).then((_) {
        Utility.showSuccessMessage("The evnt has added uccessfully.");
        Provider.of<EventsProvider>(context, listen: false).getEvents();
        Navigator.of(context).pop();
      });
    }
  }
}
