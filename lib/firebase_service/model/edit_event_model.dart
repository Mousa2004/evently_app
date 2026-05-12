import 'package:evently_app/feature/auth/widget/customedTextFormFieled.dart';
import 'package:evently_app/feature/auth/widget/customedbutton.dart';
import 'package:evently_app/firebase_service/firebase_services.dart';
import 'package:evently_app/feature/home/home_screan.dart';
import 'package:evently_app/feature/l10n/app_localizations.dart';
import 'package:evently_app/firebase_service/model/categories_model.dart';
import 'package:evently_app/firebase_service/model/event_model.dart';
import 'package:evently_app/feature/provider/events_provider.dart';
import 'package:evently_app/feature/provider/settingtheme_provider.dart';
import 'package:evently_app/feature/tabs/home_tab/widget/tabbar_item.dart';
import 'package:evently_app/utils/themeapp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditEventModel extends StatefulWidget {
  final EventModel event;

  const EditEventModel({super.key, required this.event});

  @override
  State<EditEventModel> createState() => _EditEventModelState();
}

class _EditEventModelState extends State<EditEventModel> {
  int currentIndex = 0;

  CategoriesModel? selectCategory;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  DateTime? selectData;
  TimeOfDay? selectTime;
  DateFormat dateFormat = DateFormat('d/M/yyyy');
  @override
  void initState() {
    super.initState();

    titleController.text = widget.event.title;
    descriptionController.text = widget.event.description;

    selectData = widget.event.dateTime;
    selectTime = TimeOfDay.fromDateTime(widget.event.dateTime);
  }

  bool _isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInit) {
      final categories = CategoriesModel.categories(context);

      selectCategory = categories.firstWhere(
        (c) => c.id == widget.event.categoryId,
        orElse: () => categories.first,
      );

      currentIndex = categories.indexOf(selectCategory!);

      _isInit = true;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    SettingthemeProvider settingthemeProvider =
        Provider.of<SettingthemeProvider>(context);

    final categories = CategoriesModel.categories(context);

    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.editEvent)),
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
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.asset(
                    "assets/images/${selectCategory?.imageName ?? 'default'}.png",
                    height: MediaQuery.sizeOf(context).height * 0.23.h,
                    width: MediaQuery.sizeOf(context).width,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: DefaultTabController(
                length: categories.length,
                child: TabBar(
                  labelPadding: const EdgeInsets.only(right: 10),
                  isScrollable: true,
                  indicatorColor: Colors.transparent,
                  dividerColor: Colors.transparent,
                  tabAlignment: TabAlignment.start,

                  onTap: (index) {
                    setState(() {
                      currentIndex = index;
                      selectCategory = categories[index];
                    });
                  },

                  tabs: List.generate(categories.length, (index) {
                    final category = categories[index];

                    return TabbarItem(
                      imageIcon: category.imageIcon,
                      text: category.name,
                      isSelect: currentIndex == index,
                      selectColor: settingthemeProvider.isDark
                          ? Themeapp.black
                          : Themeapp.white,
                      unselectColor: Themeapp.primary,
                      colorBorder: Themeapp.primary,
                      selectBackgroundColor: Themeapp.primary,
                    );
                  }),
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
                    Text(appLocalizations.title),
                    SizedBox(height: 8.h),

                    Customedtextformfieled(
                      hint: appLocalizations.eventTitle,
                      colorHint: Themeapp.grey,
                      imageName: "title_edit",
                      controller: titleController,
                    ),

                    SizedBox(height: 16.h),

                    Text(appLocalizations.description),
                    SizedBox(height: 8.h),

                    Customedtextformfieled(
                      hint: appLocalizations.eventDescription,
                      colorHint: Themeapp.grey,
                      imageName: "title_edit",
                      controller: descriptionController,
                    ),

                    SizedBox(height: 16.h),

                    /// DATE
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/data.svg"),
                        const SizedBox(width: 5),
                        Text(appLocalizations.eventData),
                        const Spacer(),
                        InkWell(
                          onTap: () async {
                            DateTime? data = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                            );

                            if (data != null) {
                              setState(() => selectData = data);
                            }
                          },
                          child: Text(
                            selectData == null
                                ? appLocalizations.chooseData
                                : dateFormat.format(selectData!),
                            style: const TextStyle(color: Themeapp.primary),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    /// TIME
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/time.svg"),
                        const SizedBox(width: 5),
                        Text(appLocalizations.eventTime),
                        const Spacer(),
                        InkWell(
                          onTap: () async {
                            TimeOfDay? time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );

                            if (time != null) {
                              setState(() => selectTime = time);
                            }
                          },
                          child: Text(
                            selectTime == null
                                ? appLocalizations.chooseTime
                                : selectTime!.format(context),
                            style: const TextStyle(color: Themeapp.primary),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    Customedbutton(
                      name: appLocalizations.editEvent,
                      onPressed: () => editEvent(),
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

  void editEvent() {
    if (formstate.currentState!.validate() &&
        selectData != null &&
        selectTime != null &&
        selectCategory != null) {
      DateTime dateTime = DateTime(
        selectData!.year,
        selectData!.month,
        selectData!.day,
        selectTime!.hour,
        selectTime!.minute,
      );

      EventModel event = EventModel(
        id: widget.event.id,
        userId: FirebaseAuth.instance.currentUser!.uid,
        categoryId: selectCategory!.id,
        title: titleController.text,
        description: descriptionController.text,
        dateTime: dateTime,
      );

      FirebaseServices.editEvent(event).then((_) {
        Provider.of<EventsProvider>(context, listen: false).getEvents();
        Navigator.of(context).pushReplacementNamed(HomeScrean.routName);
      });
    }
  }
}
