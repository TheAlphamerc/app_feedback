import 'package:app_feedback/src/cubit/feedback_cubit.dart';
import 'package:app_feedback/src/helper/shared_prefrence_helper.dart';
import 'package:app_feedback/src/helper/util.dart';
import 'package:app_feedback/src/model/feedback.dart';
import 'package:app_feedback/src/widget/feedback_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Option {
  /// The `duration` define interval of time after which form needs tro be displayed
  final Duration duration;

  /// The `displayLogs` determine whether to display logs on console or not.
  ///
  /// Used for debugging
  final bool displayLogs;

  /// Set initial rating in form
  final int defaultRating;

  final String defaultReview;
  Option({
    this.duration,
    this.defaultRating,
    this.displayLogs = false,
    this.defaultReview = "",
  });

  factory Option.defaultOption() {
    return new Option(
      displayLogs: false,
      duration: Duration(seconds: 1),
    );
  }

  @override
  toString() =>
      "oneTimeOnly => \nduration => ${duration.toString()}\ndisplayLogs=> $displayLogs\ninitialRating=> $defaultRating\nreview=> $defaultReview";
}

abstract class AppFeedback {
  static final AppFeedback _instance = AppFeedbackImpl();

  /// access to the Singleton instance of LoaderService
  static AppFeedback get instance => _instance;

  /// initilise the `AppFeedback` form.
  /// ```dart
  ///  AppFeedback feedback = AppFeedback.instance;
  ///  @override
  ///  void initState() {
  ///    feedback.init(Option(duration: Duration(seconds: 10), displayLogs: true));
  ///    super.initState();
  ///  }
  /// ```
  void init(Option option);

  /// Display form after specific interval of time.
  ///
  /// `AppFeedback` form will be displayed once `duration` provided  in [void init(Option option)] is over
  ///
  /// If `duration` is remaing then nothing will be displayed
  ///```dart
  /// void checkAppFeedback() {
  ///   feedback.tryDisplay(context, onSubmit: (feedback) {
  ///     print(feedback.toString());
  ///   });
  /// }
  ///```
  void tryDisplay(BuildContext context,
      {Function(UserFeedback) onSubmit, VoidCallback onSkip});

  /// Invoking `display` method will be displayed `AppFeedback` form instantly
  display(BuildContext context,
      {Function(UserFeedback) onSubmit, Option option});
  Future<UserFeedback> get savedFeedback;

  /// Clear the saved feedback data.
  ///
  /// It is recommended to initilise the `AppFeedback` form after reset.
  Future<bool> reset();
}

class AppFeedbackImpl implements AppFeedback {
  Option option = Option.defaultOption();
  SharedPreferenceHelper pref;

  /// Initilise the app feedback form
  @override
  void init(Option option) async {
    this.option = option;
    pref = SharedPreferenceHelper();
    var feedback = await pref.getAppFeedback();
    if (feedback != null) {
      final diff = DateTime.now().difference(feedback.createdAt);

      Util.cprint("form initialised ${diff.toString()} ago",
          display: option.displayLogs);
    } else {
      /// Initilise the timer for the first time
      await pref.saveAppFeedback(UserFeedback(createdAt: DateTime.now()));
      Util.cprint("initialise for first time", display: option.displayLogs);
    }
  }

  @override
  void tryDisplay(BuildContext context,
      {Function(UserFeedback) onSubmit, VoidCallback onSkip}) async {
    assert(
        pref != null,
        "Seems like feedback form isn't initilise" +
            "\nTry to initilise the feedback form first by using below code" +
            "\n\n@override" +
            "\nvoid initState() {" +
            "\n AppFeedback.instance.init(Option(duration: Duration(seconds: 10), displayLogs: true));" +
            "\n super.initState();" +
            "\n}\n");

    /// Check if there is already a feedback in local cache
    var feedback = await pref.getAppFeedback();
    if (feedback != null) {
      final diff = DateTime.now().difference(feedback.createdAt);

      /// If user haven't submiited feedback
      /// And if initial feedback duration is found to be longer then user's provided duration.
      /// Display feedback form
      if (feedback.rating == null && diff.compareTo(option.duration) > 0) {
        /// Reset  timer to display FeedbackPage after [Option.duration]
        await pref.saveAppFeedback(UserFeedback(createdAt: DateTime.now()));

        /// Display sheet
        display(context, onSubmit: onSubmit, option: option, onSkip: onSkip);
      }

      /// If users alreay submitted his feedback
      /// And provided duration is expired then its time to ask user to give feedback again
      else if (feedback.rating != null && diff.compareTo(option.duration) > 0) {
        /// Reset save timing to display FeedbackPage after 7 Days.
        await pref
            .saveAppFeedback(feedback.copyWith(createdAt: DateTime.now()));

        /// Display sheet
        display(context, onSubmit: onSubmit, option: option, onSkip: onSkip);
      } else {
        final remaing = option.duration - diff;
        Util.cprint("Remaing time: ${remaing.toString()}",
            display: option.displayLogs);
      }
    }
  }

  @override
  display(
    BuildContext context, {
    Function(UserFeedback) onSubmit,
    VoidCallback onSkip,
    Option option,
  }) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return BlocProvider(
          create: (context) => FeedbackCubit(option),
          child: FeedbackPage(
            onSkip: onSkip,
            onSubmit: onSubmit,
            option: option,
          ),
        );
      },
    );
  }

  @override
  Future<UserFeedback> get savedFeedback => pref.getAppFeedback();

  @override
  Future<bool> reset() {
    return pref.resetForm();
  }
}
