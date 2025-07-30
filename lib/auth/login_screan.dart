import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:evently_app/auth/register_screan.dart';
import 'package:evently_app/componemt/customedTextFormFieled.dart';
import 'package:evently_app/componemt/customedbutton.dart';
import 'package:evently_app/componemt/logo_srean.dart';
import 'package:evently_app/componemt/utility.dart';
import 'package:evently_app/firebase_services.dart';
import 'package:evently_app/home_screan.dart';
import 'package:evently_app/themeapp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScrean extends StatefulWidget {
  static const String routName = "/login";
  const LoginScrean({super.key});

  @override
  State<LoginScrean> createState() => _LoginScreanState();
}

class _LoginScreanState extends State<LoginScrean> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool _obscureText = true;

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return;

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushReplacementNamed(HomeScrean.routName);
  }

  @override
  Widget build(BuildContext context) {
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
                        hint: "Email",
                        imageName: "email",
                        controller: email,
                        validator: (p0) {
                          if (p0 == '') return "Enter your email";
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),
                      Customedtextformfieled(
                        controller: password,
                        hint: "Password",
                        imageName: "password",
                        validator: (p0) {
                          if (p0 == '' || p0!.length < 6) {
                            return "Password must at lest 6 number";
                          }
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
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    onTap: () async {
                      if (email.text == "") {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.info,
                          animType: AnimType.rightSlide,
                          title: 'Enter your email',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {},
                        ).show();
                        return;
                      }
                      try {
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                          email: email.text,
                        );
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.rightSlide,
                          title:
                              'Please check your email to reset your password',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {},
                        ).show();
                      } catch (e) {
                        print(e);
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Re-enter your email address',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {},
                        ).show();
                      }
                    },
                    child: Text(
                      textAlign: TextAlign.end,
                      "Forget Password?",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Themeapp.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: Themeapp.primary,
                        fontWeight: FontWeight.w700,
                        decorationThickness: 2,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                Customedbutton(name: "Login", onPressed: login),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t Have Account ? ",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(
                          context,
                        ).pushReplacementNamed(RegisterScrean.routName);
                      },
                      child: Text(
                        "Create Account",
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
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: Row(
                    children: [
                      Expanded(child: Divider(color: Themeapp.primary)),
                      Text(
                        "   Or  ",
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: Themeapp.primary),
                      ),
                      Expanded(child: Divider(color: Themeapp.primary)),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Themeapp.primary),
                  ),
                  child: MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    onPressed: () {
                      signInWithGoogle();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/google.png",
                          height: 26,
                          width: 26,
                          fit: BoxFit.scaleDown,
                        ),
                        Text(
                          "  Login With Google",
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (formState.currentState!.validate()) {
      FirebaseServices.login(email: email.text, password: password.text)
          .then((user) {
            Utility.showSuccessMessage("You have successfully logged in.");
            Navigator.of(context).pushReplacementNamed(HomeScrean.routName);
          })
          .catchError((error) {
            String? errormessage;
            if (error is FirebaseAuthException) {
              errormessage = error.message;
            }
            Utility.showErrorMessage(errormessage);
          });
    }
  }
}
