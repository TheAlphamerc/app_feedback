part of 'feedback_cubit.dart';

@immutable
abstract class FeedbackState {}

class FeedbackInitial extends FeedbackState {}

class FeedbackRating extends FeedbackState {
  final int rating;

  FeedbackRating(this.rating);
}
