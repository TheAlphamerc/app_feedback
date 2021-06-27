import 'package:app_feedback/app_feedback.dart';
import 'package:app_feedback/src/helper/shared_prefrence_helper.dart';
import 'package:app_feedback/src/model/options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_feedback/src/model/feedback.dart';
part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  final Option option;
  final bool saveToCache;
  FeedbackCubit(this.option, {this.saveToCache = false})
      : super(FeedbackInitial()) {
    review = TextEditingController();
    if (option != null && option.defaultRating != null) {
      if (option.defaultRating != null) {
        setRating = option.defaultRating - 1;
      }
      review.text = option.defaultReview;
    }
  }

  int rating;
  TextEditingController review;
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  set setRating(int rating) {
    this.rating = rating;
    emit(FeedbackRating(rating));
  }

  Future<UserFeedback> getFeedback() async {
    UserFeedback feedback = UserFeedback(
        rating: rating + 1, review: review.text, createdAt: DateTime.now());
    if (saveToCache) {
      final pref = SharedPreferenceHelper();
      await pref.saveAppFeedback(feedback);
    }

    return feedback;
  }

  @override
  Future<void> close() {
    isLoading.dispose();
    return super.close();
  }
}
