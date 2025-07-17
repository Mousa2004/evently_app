import 'package:evently_app/home_screan.dart';
import 'package:evently_app/onboarding/onboarding_item.dart';
import 'package:evently_app/onboarding/switch_item.dart';
import 'package:evently_app/themeapp.dart' show Themeapp;
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatefulWidget {
  static const String routName = "/onboarding";
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  bool language = false;
  bool theme = false;
  int currentIndex = 0;
  final introKey = GlobalKey<IntroductionScreenState>();

  List<Map<String, String>> onboradingList = [
    {
      "image": "assets/images/onboarding1.png",
      "title": "Personalize Your Experience",
      "body":
          "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
    },
    {
      "image": "assets/images/onboarding2.png",
      "title": "Find Events That Inspire You",
      "body":
          "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
    },
    {
      "image": "assets/images/onboarding3.png",
      "title": "Effortless Event Planning",
      "body":
          "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
    },
    {
      "image": "assets/images/onboarding4.png",
      "title": "Connect with Friends & Share Moments",
      "body":
          "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/onboarding_logo.png"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
              Expanded(
                child: SizedBox(
                  child: IntroductionScreen(
                    key: introKey,
                    onChange: (value) {
                      currentIndex = value;
                      setState(() {});
                    },
                    pages: onboradingList.asMap().entries.map((entry) {
                      var item = entry.value;
                      return PageViewModel(
                        image: Image.asset(
                          "${item['image']}",
                          height: MediaQuery.sizeOf(context).height * 0.9,
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          fit: BoxFit.fill,
                        ),
                        titleWidget: SizedBox(
                          width: double.infinity,
                          child: Text(
                            "${item['title']}",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        bodyWidget: Column(
                          children: [
                            Text(
                              "${item['body']}",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.03,
                            ),
                            currentIndex != 0
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.only(bottom: 40),
                                    child: Column(
                                      children: [
                                        SwitchItem(
                                          name: "Language",
                                          imageName1: "eng",
                                          imageName2: "ar",
                                        ),
                                        SizedBox(
                                          height:
                                              MediaQuery.sizeOf(
                                                context,
                                              ).height *
                                              0.03,
                                        ),
                                        SwitchItem(
                                          name: "Theme",
                                          imageName1: "sun",
                                          imageName2: "moon",
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      );
                    }).toList(),
                    showNextButton: currentIndex != 0,
                    showBackButton: currentIndex != 0,

                    next: OnboardingItem(
                      margin: EdgeInsets.only(
                        left: MediaQuery.sizeOf(context).width * 0.13,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    done: OnboardingItem(
                      margin: EdgeInsets.only(
                        left: MediaQuery.sizeOf(context).width * 0.13,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    onDone: () async {
                      SharedPreferences sharedPref =
                          await SharedPreferences.getInstance();
                      sharedPref.setBool("onboarding", true);
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(HomeScrean.routName);
                    },

                    back: OnboardingItem(
                      margin: EdgeInsets.only(
                        right: MediaQuery.sizeOf(context).width * 0.13,
                      ),
                    ),
                    dotsDecorator: currentIndex == 0
                        ? DotsDecorator(
                            size: Size(0, 0),
                            activeSize: Size(0, 0),
                          )
                        : DotsDecorator(
                            color: Themeapp.black,
                            activeColor: Themeapp.primary,
                            activeSize: Size(20, 10),
                            activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(36),
                            ),
                          ),
                  ),
                ),
              ),

              currentIndex != 0
                  ? Container()
                  : Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 16, right: 16, bottom: 27),
                      decoration: BoxDecoration(
                        color: Themeapp.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          introKey.currentState!.next();
                        },
                        child: Text(
                          "Let’s Start",
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(
                                color: Themeapp.white,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
