import 'package:app_feedback/src/cubit/feedback_cubit.dart';
import 'package:app_feedback/src/helper/shared_prefrence_helper.dart';
import 'package:app_feedback/src/model/feedback.dart';
import 'package:app_feedback/src/widget/feedback_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Option {
  final bool oneTimeOnly;
  final Duration duration;
  final bool displayLogs;
  Option({this.oneTimeOnly, this.duration, this.displayLogs = false});
}

abstract class AppFeedback {
  static final AppFeedback _instance = AppFeedbackImpl();

  /// access to the Singleton instance of LoaderService
  static AppFeedback get instance => _instance;

  void init(Option option);

  void checkAppRating(BuildContext context,
      {Function(UserFeedback) onSubmit, VoidCallback onSkip});

  displayAppFeedbackSheet(BuildContext context,
      {Function(UserFeedback) onSubmit});
}

class AppFeedbackImpl implements AppFeedback {
  Option option;
  @override
  void init(Option option) async {
    this.option = option;
    final pref = SharedPreferenceHelper();
    var feedback = await pref.getAppFeedback();
    if (feedback != null) {
      final diff = DateTime.now().difference(feedback.createdAt);
    } else {
      await pref.saveAppFeedback(UserFeedback(createdAt: DateTime.now()));
    }
  }

  @override
  void checkAppRating(BuildContext context,
      {Function(UserFeedback) onSubmit, VoidCallback onSkip}) async {
    final pref = SharedPreferenceHelper();
    var feedback = await pref.getAppFeedback();
    if (feedback != null) {
      final diff = DateTime.now().difference(feedback.createdAt);

      /// Users who haven't submitted feedback'
      if (feedback.rating == null && diff.compareTo(option.duration) > 0) {
        /// Reset save timing to display FeedbackPage after 72 hours.
        await pref.saveAppFeedback(UserFeedback(createdAt: DateTime.now()));

        /// Display sheet
        displayAppFeedbackSheet(context, onSubmit: onSubmit);
      }

      /// users who have already submitted feedback
      else if (feedback.rating != null && diff.inDays > 7) {
        /// Reset save timing to display FeedbackPage after 7 Days.
        await pref
            .saveAppFeedback(feedback.copyWith(createdAt: DateTime.now()));

        /// Display sheet
        displayAppFeedbackSheet(context, onSubmit: onSubmit);
      }
    }

    /// Initilise the timer for the first time
    else {
      await pref.saveAppFeedback(UserFeedback(createdAt: DateTime.now()));
    }
  }

  @override
  displayAppFeedbackSheet(BuildContext context,
      {Function(UserFeedback) onSubmit, VoidCallback onSkip}) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return BlocProvider(
          create: (context) => FeedbackCubit(),
          child: FeedbackPage(onSkip: onSkip, onSubmit: onSubmit),
        );
      },
    );
  }
}
