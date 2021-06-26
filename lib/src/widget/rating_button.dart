import 'package:app_feedback/src/model/rating_button/rating_button_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:app_feedback/src/theme/theme.dart';

typedef RatingButtonBuilder = Widget Function(
  BuildContext,
  int index,
  bool isSelected,
);

class RatingButton extends StatelessWidget {
  final bool isActive;
  final int index;
  final Function(int) onPressed;
  final ShapeBorder shape;
  final RatingButtonThemeData theme;
  const RatingButton({
    Key key,
    this.isActive,
    this.index,
    this.onPressed,
    this.shape = const RoundedRectangleBorder(),
    this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: theme.minWidth,
      padding: theme.padding,
      onPressed: () => onPressed(index),
      shape: theme.shape,
      color: !isActive
          ? theme.inActiveColor ?? context.onPrimary
          : theme.activeColor ?? Theme.of(context).primaryColor,
      elevation: theme.elevation,
      child: Text(
        "$index",
        style: isActive ? theme.activeTextStyle : theme.inActiveTextStyle,
      ),
    );
  }
}
