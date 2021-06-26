import 'package:app_feedback/app_feedback.dart';
import 'package:app_feedback/src/cubit/feedback_cubit.dart';
import 'package:app_feedback/src/model/feedback.dart';
import 'package:app_feedback/src/model/options.dart';
import 'package:app_feedback/src/model/rating_button/rating_button_theme_data.dart';
import 'package:app_feedback/src/theme/theme.dart';
import 'package:app_feedback/src/widget/custom_button.dart';
import 'package:app_feedback/src/widget/rating_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbackPage extends StatelessWidget {
  final Function(UserFeedback) onSubmit;
  final VoidCallback onSkip;
  final Option option;
  final RatingButtonBuilder ratingButtonBuilder;
  const FeedbackPage(
      {Key key,
      this.onSubmit,
      this.onSkip,
      this.option,
      this.ratingButtonBuilder})
      : super(key: key);

  static MaterialPageRoute getRoute() {
    return new MaterialPageRoute(
      builder: (_) => FeedbackPage(),
      fullscreenDialog: true,
    );
  }

  Widget _ratingRow(BuildContext context) {
    return Container(
      width: context.width,
      child: Column(
        children: [
          BlocBuilder<FeedbackCubit, FeedbackState>(
            builder: (context, state) {
              int rating = -1;
              if (state is FeedbackRating) {
                rating = state.rating;
              }
              return Wrap(
                spacing: 2,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                runSpacing: 2,
                children: Iterable.generate(
                        option.maxRating,
                        (inedx) =>
                            _ratingButton(context, inedx, rating == inedx))
                    .toList(),
              );
            },
          ),
          if (!option.hideRatingBottomText)
            Row(
              children: [
                Text(
                  option.ratringsBottomText1,
                  style: option.ratingbottomTextStyle ??
                      TextStyles.headline14(context),
                ),
                Spacer(),
                Text(
                  option.ratringsBottomText2,
                  style: option.ratingbottomTextStyle ??
                      TextStyles.headline14(context),
                ),
              ],
            )
        ],
      ),
    );
  }

  Widget _ratingButton(BuildContext context, int index, bool isActive) {
    index += 1;
    if (ratingButtonBuilder != null) {
      return InkWell(
        onTap: () {
          context.read<FeedbackCubit>().setRating = index - 1;
        },
        child: ratingButtonBuilder(context, index, isActive),
      );
    }
    return RatingButton(
      index: index,
      isActive: isActive,
      onPressed: (val) {
        context.read<FeedbackCubit>().setRating = index - 1;
      },
      theme: option.ratingButtonTheme ?? RatingButtonThemeData.defaultTheme,
    );
    return OutlinedButton(
      onPressed: () {
        context.read<FeedbackCubit>().setRating = index - 1;
      },
      style: ButtonStyle(
          shape: MaterialStateProperty.all(ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(10))),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          foregroundColor: MaterialStateProperty.all(
              isActive ? context.onPrimary : context.primaryColor),
          backgroundColor: MaterialStateProperty.all(
              !isActive ? context.onPrimary : context.primaryColor),
          side: MaterialStateProperty.all(
              BorderSide(color: context.disabledColor)),
          textStyle: MaterialStateProperty.all(TextStyles.headline18(context))),
      child: Text("$index"),
    ).pR(index == 10 ? 0 : 5);
  }

  Widget _suggestionField(BuildContext context) {
    if (option.hideSuggestionField) {
      return SizedBox();
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            option.reviewFieldHeader,
            style:
                option.reviewHeaderTextStyle ?? TextStyles.headline16(context),
          ).pB(12),
          TextFormField(
            maxLines: 5,
            controller: context.select((FeedbackCubit value) => value.review),
            style:
                option.reviewfieldTextStyle ?? TextStyles.bodyText15(context),
            decoration: InputDecoration(
              hintText: option.reviewFieldHint,
              hintStyle: option.reviewFieldHintTextStyle ??
                  TextStyles.bodyText14(context),
              border: OutlineInputBorder(),
            ),
          )
        ],
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              style: option.skipButtonStyle,
              child: Text(option.skipButtonText),
            ),
          ),
          CustomButton(
            isWraped: true,
            label: option.submitButtonText,
            isColored: true,
            isLoading: context.select((FeedbackCubit value) => value.isLoading),
            buttonStyle: option.submitButtonStyle,
            labelStyle: option.submitButtonTextStyle ??
                TextStyles.headline16(context)
                    .copyWith(fontSize: 14)
                    .onPrimary(context),
            onPressed: () async {
              final state = context.read<FeedbackCubit>();
              if (state.rating == null) {
                return;
              }
              if (onSubmit != null) {
                var model = await context.read<FeedbackCubit>().getFeedback();
                onSubmit(model);
              }
              Navigator.pop(context);
            },
          ).pR(16)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        children: [
          Column(
            children: [
              Text(option.ratingHeader,
                      style: option.ratingHeaderTextStyle ??
                          TextStyles.headline16(context))
                  .vP16,
              _ratingRow(context).pB(24),
              _suggestionField(context).pB(30),
            ],
          ).hP16,
          _submitButton(context).pB(30)
        ],
      ),
    );
  }
}