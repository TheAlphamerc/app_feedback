import 'package:flutter/material.dart';

class RatingButtonThemeData {
  /// Set minimum width of button
  final double minWidth;

  /// Set height of button
  final double height;

  /// Set button backgroundColor when selected
  final Color activeColor;

  /// Set button backgroundColor when unselected
  final Color inActiveColor;

  /// Set button text style when selected
  final TextStyle activeTextStyle;

  /// Set button text when unselected
  final TextStyle inActiveTextStyle;

  /// The highlight indicates that the button is actively being pressed.
  ///
  /// It appears on top of the button's child and quickly spreads to fill the button, and then fades out.
  final Color highlightColor;

  ///The ink splash indicates that the button has been touched.
  ///
  /// It appears on top of the button's child and spreads in an expanding circle beginning where the touch occurred.
  final Color splashColor;

  /// The button's highlight and splash are clipped to this shape. If the button has an elevation, then its drop shadow is defined by this shape as well.
  final ShapeBorder shape;

  /// This controls the size of the shadow below the raised button.
  final double elevation;

  /// The internal padding for the button.
  final EdgeInsetsGeometry padding;

  /// Defines how compact the button's layout will be.
  final VisualDensity visualDensity;
  const RatingButtonThemeData({
    this.minWidth,
    this.height,
    this.activeTextStyle,
    this.activeColor,
    this.inActiveColor,
    this.inActiveTextStyle,
    this.highlightColor,
    this.splashColor,
    this.shape,
    this.elevation,
    this.padding,
    this.visualDensity,
  });

  RatingButtonThemeData copyWith({
    double minWidth,
    double height,
    TextStyle activeTextStyle,
    TextStyle inActiveTextStyle,
    Color inActiveColor,
    Color activeColor,
    Color textColor,
    Color highlightColor,
    Color splashColor,
    ShapeBorder shape,
    double elevation,
    EdgeInsetsGeometry padding,
    VisualDensity visualDensity,
  }) {
    return RatingButtonThemeData(
      activeTextStyle: activeTextStyle ?? this.activeTextStyle,
      minWidth: minWidth ?? this.minWidth,
      activeColor: activeColor ?? this.activeColor,
      elevation: elevation ?? this.elevation,
      height: height ?? this.height,
      highlightColor: highlightColor ?? this.highlightColor,
      inActiveColor: inActiveColor ?? this.inActiveColor,
      padding: padding ?? this.padding,
      shape: shape ?? this.shape,
      splashColor: splashColor ?? this.splashColor,
      inActiveTextStyle: inActiveTextStyle ?? this.inActiveTextStyle,
      visualDensity: visualDensity ?? this.visualDensity,
    );
  }

  static RatingButtonThemeData get defaultTheme => RatingButtonThemeData(
        activeTextStyle: TextStyle(fontSize: 14),
        minWidth: 40,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            side: BorderSide(width: .8, color: Colors.grey[300])),
        elevation: 0,
      );

  static RatingButtonThemeData roundedBorder(
          {BorderSide side = BorderSide.none,
          BorderRadiusGeometry borderRadius = BorderRadius.zero}) =>
      defaultTheme.copyWith(
          shape:
              RoundedRectangleBorder(side: side, borderRadius: borderRadius));

  static RatingButtonThemeData get circular =>
      defaultTheme.copyWith(shape: CircleBorder());

  static RatingButtonThemeData circularOutlined(
          {Color color = const Color(4278190080),
          double width = 1.0,
          BorderStyle style = BorderStyle.solid}) =>
      circular.copyWith(
        shape: CircleBorder(
          side: BorderSide(
            color: color,
            width: width,
            style: style,
          ),
        ),
      );
}
