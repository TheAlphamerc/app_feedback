import 'dart:convert';

import 'package:app_feedback/src/model/feedback.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  SharedPreferenceHelper._internal();
  static final SharedPreferenceHelper _singleton =
      SharedPreferenceHelper._internal();

  factory SharedPreferenceHelper() {
    return _singleton;
  }

  Future<bool> resetForm() async {
    var pref = await SharedPreferences.getInstance();
    if (pref.containsKey(_FeedbackFormKey.AppFeedback.toString())) {
      pref.remove(_FeedbackFormKey.AppFeedback.toString());
    }
    return true;
  }

  Future<bool> saveAppFeedback(UserFeedback model) async {
    return (await SharedPreferences.getInstance()).setString(
        _FeedbackFormKey.AppFeedback.toString(), json.encode(model.toJson()));
  }

  Future<UserFeedback?> getAppFeedback() async {
    final jsonString = (await SharedPreferences.getInstance())
        .getString(_FeedbackFormKey.AppFeedback.toString());
    if (jsonString == null) {
      return null;
    }
    return UserFeedback.fromJson(json.decode(jsonString));
  }
}

enum _FeedbackFormKey { AppFeedback }
