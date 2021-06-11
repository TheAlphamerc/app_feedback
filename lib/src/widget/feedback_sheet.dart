import 'package:app_feedback/src/cubit/feedback_cubit.dart';
import 'package:app_feedback/src/model/feedback.dart';
import 'package:app_feedback/src/theme/theme.dart';
import 'package:app_feedback/src/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbackPage extends StatelessWidget {
  final Function(UserFeedback) onSubmit;
  final VoidCallback onSkip;
  const FeedbackPage({Key key, this.onSubmit, this.onSkip}) : super(key: key);

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
              return Row(
                children: Iterable.generate(
                        10,
                        (inedx) =>
                            _rationButton(context, inedx, rating == inedx))
                    .toList(),
              );
            },
          ),
          Row(
            children: [
              Text(
                "Not for all",
                style: TextStyles.headline16(context),
              ),
              Spacer(),
              Text(
                "Yes, Definitely",
                style: TextStyles.headline16(context),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _rationButton(BuildContext context, int index, bool isActive) {
    index += 1;
    return OutlinedButton(
      onPressed: () {
        context.read<FeedbackCubit>().setRating = index - 1;
      },
      style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          foregroundColor: MaterialStateProperty.all(
              isActive ? context.onPrimary : context.primaryColor),
          backgroundColor: MaterialStateProperty.all(
              !isActive ? context.onPrimary : context.primaryColor),
          side: MaterialStateProperty.all(
              BorderSide(color: context.disabledColor)),
          textStyle: MaterialStateProperty.all(TextStyles.headline18(context))),
      child: Text("$index"),
    ).pR(index == 10 ? 0 : 5).extended;
  }

  Widget _suggestionField(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "We would love to improve on your suggestion.",
            style: TextStyles.headline16(context),
          ).pB(12),
          TextFormField(
            maxLines: 5,
            controller:
                context.select((FeedbackCubit value) => value.controller),
            decoration: InputDecoration(
              hintText: "Tell us here",
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
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            child: Text("Skip"),
          ),
          CustomButton(
            isWraped: true,
            label: "Submit",
            isColored: true,
            isLoading: context.select((FeedbackCubit value) => value.isLoading),
            // padding: ,
            labelStyle: TextStyles.headline16(context).onPrimary(context),
            onPressed: () async {
              final state = context.read<FeedbackCubit>();
              // if (state.rating == null) {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //       SnackBar(content: Text("Choose rating first to submit")));

              //   return;
              // }
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
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Column(
            children: [
              Text("How likely are you to recommend this app to a friend?",
                      style: TextStyles.headline18(context))
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
