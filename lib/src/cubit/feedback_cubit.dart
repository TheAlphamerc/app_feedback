import 'package:app_feedback/src/helper/shared_prefrence_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:app_feedback/src/model/feedback.dart';
part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit() : super(FeedbackInitial()) {
    controller = TextEditingController();
  }

  int rating;
  TextEditingController controller;
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  set setRating(int rating) {
    this.rating = rating;
    emit(FeedbackRating(rating));
  }

  Future<UserFeedback> getFeedback() async {
    UserFeedback feedback = UserFeedback(
        rating: rating + 1, review: controller.text, createdAt: DateTime.now());
    // isLoading.value = true;
    // var response = await miscRepo.saveFeedback(request);
    // isLoading.value = false;
    // response.fold((l) => null, (r) {
    // final pref = getIt<SharedPreferenceHelper>();
    // pref.saveAppFeedback(request.copyWith.call(createdAt: DateTime.now()));

    // });
    final pref = SharedPreferenceHelper();
    await pref.saveAppFeedback(feedback);

    return feedback;
  }

  @override
  Future<void> close() {
    isLoading.dispose();
    return super.close();
  }
}
