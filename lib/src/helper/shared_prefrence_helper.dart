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
    return pref.clear();
  }

  Future<bool> setInitialLoad(bool value) async {
    return (await SharedPreferences.getInstance())
        .setBool(UserPreferenceKey.IsFirstTimeApp.toString(), value);
  }

  Future<bool> isFirstTime() async {
    return (await SharedPreferences.getInstance())
        .getBool(UserPreferenceKey.IsFirstTimeApp.toString());
  }

  Future<bool> saveAppFeedback(UserFeedback model) async {
    return (await SharedPreferences.getInstance()).setString(
        UserPreferenceKey.AppFeedback.toString(), json.encode(model.toJson()));
  }

  Future<UserFeedback> getAppFeedback() async {
    final jsonString = (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.AppFeedback.toString());
    if (jsonString == null) {
      return null;
    }
    return UserFeedback.fromJson(json.decode(jsonString));
  }
}

enum UserPreferenceKey { IsFirstTimeApp, AppFeedback }
