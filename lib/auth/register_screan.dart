import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:evently_app/auth/login_screan.dart';
import 'package:evently_app/componemt/customedTextFormFieled.dart';
import 'package:evently_app/componemt/customedbutton.dart';
import 'package:evently_app/componemt/logo_srean.dart';
import 'package:evently_app/themeapp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScrean extends StatefulWidget {
  static const String routName = "/register";
  const RegisterScrean({super.key});

  @override
  State<RegisterScrean> createState() => _RegisterScreanState();
}

class _RegisterScreanState extends State<RegisterScrean> {
  TextEditingController person = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              LogoSrean(),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.04),
              Form(
                key: formState,
                child: Column(
                  children: [
                    Customedtextformfieled(
                      hint: "Name",
                      imageName: "person",
                      controller: person,
                      validator: (val) {
                        if (val == "") return "Enter your name";
                      },
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                    Customedtextformfieled(
                      hint: "Email",
                      imageName: "email",
                      controller: email,
                      validator: (val) {
                        if (val == "") return "Enter your email";
                      },
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                    Customedtextformfieled(
                      controller: password,
                      hint: "Password",
                      imageName: "password",
                      validator: (val) {
                        if (val == "") return "Enter your password";
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
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              Customedbutton(
                name: "Create Account",
                onPressed: () async {
                  if (formState.currentState!.validate()) {
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                            email: email.text,
                            password: password.text,
                          );

                      Navigator.of(
                        context,
                      ).pushReplacementNamed(LoginScrean.routName);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'The password provided is too weak.',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {},
                        ).show();
                      } else if (e.code == 'email-already-in-use') {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'The account already exists for that email.',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {},
                        ).show();
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                },
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already Have Account ? ",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(LoginScrean.routName);
                    },
                    child: Text(
                      "Login",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
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
    );
  }
}
