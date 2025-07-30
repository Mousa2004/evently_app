import 'package:evently_app/themeapp.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utility {
  static void showSuccessMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Themeapp.green,
      textColor: Themeapp.white,
    );
  }

  static void showErrorMessage(String? message) {
    Fluttertoast.showToast(
      msg: message ?? "Something went wrong",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Themeapp.red,
      textColor: Themeapp.white,
    );
  }
}
