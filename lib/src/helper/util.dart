import 'package:flutter/foundation.dart';

class Util {
  static cprint(String message, {bool? display = false}) {
    if (kDebugMode && display!) {
      print("[App Feedback] $message");
    }
  }
}
