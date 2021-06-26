import 'package:app_feedback/src/model/rating_button/rating_button_theme_data.dart';
import 'package:flutter/material.dart';

class Option {
  /// The `duration` define interval of time after which form needs tro be displayed
  final Duration duration;

  /// The `displayLogs` determine whether to display logs on console or not.
  ///
  /// Used for debugging
  final bool displayLogs;

  /// The [isDismissible] parameter specifies whether the form will be dismissed when user taps on the scrim
  final bool isDismissible;

  /// Set initial rating in form
  final int defaultRating;

  /// Set initial review in form
  final String defaultReview;

  /// Hide review field
  final bool hideSuggestionField;

  /// Maximum rating which has to be displayed
  final int maxRating;

  /// Set rating header text
  final String ratingHeader;

  /// hide texts displ below ratings
  final bool hideRatingBottomText;

  /// Set text for bad rating hint
  final String ratringsBottomText1;

  /// Set text for good rating hint
  final String ratringsBottomText2;

  /// Set text review field hint
  final String reviewFieldHint;

  /// Set text for review header
  final String reviewFieldHeader;

  /// Set text for submit button
  final String submitButtonText;

  /// Set text for skip button
  final String skipButtonText;

  /// Set skip button style
  final ButtonStyle skipButtonStyle;

  /// Set submit button style
  final ButtonStyle submitButtonStyle;

  /// Set text style for submit button
  final TextStyle submitButtonTextStyle;

  /// Set text style for rating header
  final TextStyle ratingHeaderTextStyle;

  /// Set text style for rating bottom hint text
  final TextStyle ratingbottomTextStyle;

  /// Set text style for review field header
  final TextStyle reviewHeaderTextStyle;

  /// Set text style for review field hint
  final TextStyle reviewFieldHintTextStyle;

  /// Set text style for review field
  final TextStyle reviewfieldTextStyle;

  /// Set the backgroundColor of form
  final Color backgroundColor;

  /// `shape` defines the shape of the form
  final ShapeBorder shape;

  /// Customise Rating button
  final RatingButtonThemeData ratingButtonTheme;
  const Option({
    this.duration,
    this.defaultRating,
    this.maxRating = 10,
    this.defaultReview = "",
    this.skipButtonText = "Skip",
    this.submitButtonText = "Submit",
    this.reviewFieldHint = "Tell us here",
    this.ratringsBottomText2 = "Yes, Definitely",
    this.ratringsBottomText1 = "Not at all",
    this.reviewFieldHeader = "We would love to improve on your suggestion.",
    this.ratingHeader = "How likely are you to recommend this app to a friend?",
    this.displayLogs = false,
    this.isDismissible = true,
    this.hideSuggestionField = false,
    this.hideRatingBottomText = false,
    this.skipButtonStyle,
    this.submitButtonStyle,
    this.submitButtonTextStyle,
    this.ratingHeaderTextStyle,
    this.ratingbottomTextStyle,
    this.reviewHeaderTextStyle,
    this.reviewfieldTextStyle,
    this.reviewFieldHintTextStyle,
    this.backgroundColor,
    this.shape,
    this.ratingButtonTheme,
    // this.ratingButtonBuilder
  });

  factory Option.defaultOption() {
    return new Option(
      displayLogs: false,
      duration: Duration(seconds: 1),
      defaultReview: "",
    );
  }

  @override
  toString() =>
      "oneTimeOnly => \nduration => ${duration.toString()}\ndisplayLogs=> $displayLogs\ninitialRating=> $defaultRating\nreview=> $defaultReview";
}
