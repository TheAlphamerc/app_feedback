import 'package:app_feedback/src/cubit/feedback_cubit.dart';
import 'package:app_feedback/src/helper/shared_prefrence_helper.dart';
import 'package:app_feedback/src/helper/util.dart';
import 'package:app_feedback/src/model/feedback.dart';
import 'package:app_feedback/src/model/options.dart';
import 'package:app_feedback/src/widget/feedback_sheet.dart';
import 'package:app_feedback/src/widget/rating_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'app_feedback_impl.dart';

abstract class AppFeedback {
  static final AppFeedback _instance = AppFeedbackImpl();

  /// access to the Singleton instance of LoaderService
  static AppFeedback get instance => _instance;

  /// initilise the `AppFeedback` form.
  /// ```dart
  ///  AppFeedback feedback = AppFeedback.instance;
  ///  @override
  ///  void initState() {
  ///    feedbackForm.init(FeedbackConfig(duration: Duration(seconds: 10)));
  ///    super.initState();
  ///  }
  /// ```
  void init(FeedbackConfig config);

  /// Display form after specific interval of time.
  ///
  /// `AppFeedback` form will be displayed once `duration` provided  in [void init(FeedbackConfig config)] is completed
  ///
  /// If `duration` is remaing then nothing will be displayed
  ///```dart
  /// void checkAppFeedback() {
  ///   feedback.tryDisplay(context, onSubmit: (feedback) {
  ///     print(feedback.toString());
  ///   });
  /// }
  ///```
  void tryDisplay(
    BuildContext context, {
    Option option,
    RatingButtonBuilder ratingButtonBuilder,
    Function(UserFeedback) onSubmit,
    VoidCallback onSkip,
  });

  /// Invoking `display` method will be displayed `AppFeedback` form instantly
  display(
    BuildContext context, {
    RatingButtonBuilder ratingButtonBuilder,
    void Function(UserFeedback) onSubmit,
    Option option,
  });
  Future<UserFeedback> get savedFeedback;

  /// Clear the saved feedback data.
  ///
  /// It is recommended to initilise the `AppFeedback` form after reset.
  Future<bool> reset();
}
