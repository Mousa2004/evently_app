import 'package:evently_app/auth/login_screan.dart';
import 'package:evently_app/tabs/profile/profile_header.dart';
import 'package:evently_app/themeapp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  List<Language> lang = [
    Language(code: "en", lang: "English"),
    Language(code: "ar", lang: "Arabic"),
  ];

  List<String> theme = ["Light", "Dark"];
  Language? selectLanguage;
  String? selectTheme;
  @override
  void initState() {
    selectLanguage = lang[0];
    selectTheme = theme[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileHeader(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Language",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: Themeapp.black),
                ),
              ),

              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Themeapp.primary),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: DropdownButton<Language>(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  iconEnabledColor: Themeapp.primary,

                  isExpanded: true,
                  underline: SizedBox(),
                  value: selectLanguage,
                  dropdownColor: Themeapp.white,
                  borderRadius: BorderRadius.circular(16),

                  items: lang
                      .map(
                        (language) => DropdownMenuItem<Language>(
                          value: language,
                          child: Text(
                            language.lang,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (Language? value) {
                    selectLanguage = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Theme",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: Themeapp.black),
                ),
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Themeapp.primary),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: DropdownButton<String>(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  iconEnabledColor: Themeapp.primary,

                  isExpanded: true,
                  underline: SizedBox(),
                  value: selectTheme,
                  dropdownColor: Themeapp.white,
                  borderRadius: BorderRadius.circular(16),

                  items: theme
                      .map(
                        (theme) => DropdownMenuItem<String>(
                          value: theme,
                          child: Text(
                            theme,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) {
                    selectTheme = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Themeapp.red,
            borderRadius: BorderRadius.circular(16),
          ),
          child: MaterialButton(
            child: Row(
              children: [
                Icon(Icons.exit_to_app, color: Themeapp.white),
                SizedBox(width: 10),
                Text(
                  "Logout",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Themeapp.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            onPressed: () async {
              GoogleSignIn googleSignIn = GoogleSignIn();
              googleSignIn.disconnect();
              await FirebaseAuth.instance.signOut();
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(LoginScrean.routName, (route) => false);
            },
          ),
        ),
      ],
    );
  }
}

class Language {
  String code;
  String lang;
  Language({required this.code, required this.lang});
}
