import 'package:evently_app/auth/login_screan.dart';
import 'package:evently_app/componemt/customedTextFormFieled.dart';
import 'package:evently_app/componemt/customedbutton.dart';
import 'package:evently_app/componemt/logo_srean.dart';
import 'package:evently_app/componemt/utility.dart';
import 'package:evently_app/firebase_services.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/provider/settingtheme_provider.dart';
import 'package:evently_app/provider/users_provider.dart';
import 'package:evently_app/themeapp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScrean extends StatefulWidget {
  static const String routName = "/register";
  const RegisterScrean({super.key});

  @override
  State<RegisterScrean> createState() => _RegisterScreanState();
}

class _RegisterScreanState extends State<RegisterScrean> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    SettingthemeProvider settingthemeProvider =
        Provider.of<SettingthemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                LogoSrean(),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.04),
                Form(
                  key: formState,
                  child: Column(
                    children: [
                      Customedtextformfieled(
                        hint: appLocalizations.name,
                        imageName: "person",
                        controller: username,
                        validator: (val) {
                          if (val == "") return appLocalizations.enteryourname;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),
                      Customedtextformfieled(
                        hint: appLocalizations.email,
                        imageName: "email",
                        controller: email,
                        validator: (val) {
                          if (val == "") return appLocalizations.enteryouremail;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),
                      Customedtextformfieled(
                        controller: password,
                        hint: appLocalizations.password,
                        imageName: "password",
                        validator: (val) {
                          if (val == "")
                            return appLocalizations.enteryourpassword;
                        },
                        obscureText: _obscureText,
                        suffixIcon: IconButton(
                          onPressed: () {
                            _obscureText = !_obscureText;
                            setState(() {});
                          },
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: settingthemeProvider.isDark
                                ? Themeapp.white
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                Customedbutton(
                  name: appLocalizations.createAccount,
                  onPressed: () {
                    register(appLocalizations);
                  },
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      appLocalizations.alreadyHaveAccount,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: settingthemeProvider.isDark
                            ? Themeapp.white
                            : null,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pushReplacementNamed(LoginScrean.routName);
                      },
                      child: Text(
                        appLocalizations.login,
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(
                              color: Themeapp.primary,
                              decorationColor: Themeapp.primary,
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic,
                              decorationThickness: 2,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register(AppLocalizations appLocalizations) {
    if (formState.currentState!.validate()) {
      FirebaseServices.register(
            name: username.text,
            email: email.text,
            password: password.text,
          )
          .then((user) {
            Provider.of<UsersProvider>(
              context,
              listen: false,
            ).updateCurrentUser(user);
            Utility.showSuccessMessage(
              appLocalizations.theaccounthasbeencreatedsuccessfully,
            );
            Navigator.of(context).pushReplacementNamed(LoginScrean.routName);
          })
          .catchError((error) {
            String? errorMessage;
            if (error is FirebaseAuthException) {
              errorMessage = error.message;
            }
            Utility.showErrorMessage(errorMessage);
          });
    }
  }
}
