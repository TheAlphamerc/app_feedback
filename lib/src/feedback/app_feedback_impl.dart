part of 'app_feedback.dart';

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
  void tryDisplay(
    BuildContext context, {
    RatingButtonBuilder ratingButtonBuilder,
    Function(UserFeedback) onSubmit,
    VoidCallback onSkip,
  }) async {
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
        display(context,
            onSubmit: onSubmit,
            option: option,
            onSkip: onSkip,
            ratingButtonBuilder: ratingButtonBuilder);
      } else {
        final remaing = option.duration - diff;
        Util.cprint("Remaing time: ${remaing.toString()}",
            display: option.displayLogs);
      }
    }
  }

  @override
  display(BuildContext context,
      {Function(UserFeedback) onSubmit,
      VoidCallback onSkip,
      Option option,
      RatingButtonBuilder ratingButtonBuilder}) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: option.isDismissible,
      backgroundColor: option.backgroundColor ??
          Theme.of(context).bottomSheetTheme.backgroundColor,
      shape: option.shape ?? Theme.of(context).bottomSheetTheme.shape,
      builder: (context) {
        return BlocProvider(
          create: (context) => FeedbackCubit(option),
          child: FeedbackPage(
            onSkip: onSkip,
            onSubmit: onSubmit,
            ratingButtonBuilder: ratingButtonBuilder,
            option: option ?? Option.defaultOption(),
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
