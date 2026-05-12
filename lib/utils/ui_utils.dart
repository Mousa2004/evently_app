import 'package:evently_app/utils/themeapp.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class UIUtils {
  static void showLoading(BuildContext context) => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: Themeapp.transparent,
        content: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/svg/loading.json',
                height: MediaQuery.sizeOf(context).height * 0.28,
                width: MediaQuery.sizeOf(context).width * 0.3,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
    ),
  );

  static void hideLoading(BuildContext context) => Navigator.of(context).pop();

  static void showMessage(String message) =>
      Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT);
}
