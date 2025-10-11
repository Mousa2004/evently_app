import 'package:evently_app/auth/login_screan.dart';
import 'package:evently_app/firebase_services.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/provider/settingLocalizaion_provider.dart';
import 'package:evently_app/provider/settingtheme_provider.dart';
import 'package:evently_app/provider/users_provider.dart';
import 'package:evently_app/tabs/profile/profile_header.dart';
import 'package:evently_app/themeapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  List<Language> getLanguages(AppLocalizations appLocalizations) {
    return [
      Language(code: "en", lang: appLocalizations.english),
      Language(code: "ar", lang: appLocalizations.arabic),
    ];
  }

  List<String> getTheme(AppLocalizations appLocalizations) {
    return [appLocalizations.light, appLocalizations.dark];
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    SettinglocalizaionProvider settinglocalizaionProvider =
        Provider.of<SettinglocalizaionProvider>(context);
    SettingthemeProvider settingthemeProvider =
        Provider.of<SettingthemeProvider>(context);
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
                  appLocalizations.language,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: Themeapp.black),
                ),
              ),

              SizedBox(height: 16.h),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Themeapp.primary),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: DropdownButton(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  iconEnabledColor: Themeapp.primary,
                  isExpanded: true,
                  underline: SizedBox(),
                  value: settinglocalizaionProvider.language,
                  dropdownColor: Themeapp.white,
                  borderRadius: BorderRadius.circular(16.r),

                  items: getLanguages(appLocalizations)
                      .map(
                        (language) => DropdownMenuItem(
                          value: language.code,
                          child: Text(
                            language.lang,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (langCode) {
                    if (langCode == null) return;
                    settinglocalizaionProvider.changeLanguage(langCode);
                  },
                ),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                child: Text(
                  appLocalizations.theme,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: Themeapp.black),
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Themeapp.primary),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: DropdownButton<String>(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  iconEnabledColor: Themeapp.primary,

                  isExpanded: true,
                  underline: SizedBox(),
                  value: settingthemeProvider.isDark
                      ? appLocalizations.dark
                      : appLocalizations.light,
                  dropdownColor: Themeapp.white,
                  borderRadius: BorderRadius.circular(16.r),

                  items: getTheme(appLocalizations)
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
                  onChanged: (theme) {
                    if (theme == appLocalizations.dark) {
                      settingthemeProvider.changeTheme(ThemeMode.dark);
                    } else {
                      settingthemeProvider.changeTheme(ThemeMode.light);
                    }
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
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: MaterialButton(
            child: Row(
              children: [
                Icon(Icons.exit_to_app, color: Themeapp.white),
                SizedBox(width: 10.w),
                Text(
                  appLocalizations.logout,
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
              FirebaseServices.logout().then((_) {
                Navigator.of(
                  context,
                ).pushReplacementNamed(LoginScrean.routName).then((_) {
                  if (!mounted) return;
                  Provider.of<UsersProvider>(
                    context,
                    listen: false,
                  ).updateCurrentUser(null);
                });
              });
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
