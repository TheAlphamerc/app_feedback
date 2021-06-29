import 'package:flutter/material.dart';

class RatingButtonThemeData {
  /// Set minimum width of button
  final double? minWidth;

  /// Set height of button
  final double? height;

  /// Set button backgroundColor when selected
  final Color? activeColor;

  /// Set button backgroundColor when unselected
  final Color? inActiveColor;

  /// Set button text style when selected
  final TextStyle? activeTextStyle;

  /// Set button text when unselected
  final TextStyle? inActiveTextStyle;

  /// The highlight indicates that the button is actively being pressed.
  ///
  /// It appears on top of the button's child and quickly spreads to fill the button, and then fades out.
  final Color? highlightColor;

  ///The ink splash indicates that the button has been touched.
  ///
  /// It appears on top of the button's child and spreads in an expanding circle beginning where the touch occurred.
  final Color? splashColor;

  /// The button's highlight and splash are clipped to this shape. If the button has an elevation, then its drop shadow is defined by this shape as well.
  final ShapeBorder? shape;

  /// This controls the size of the shadow below the raised button.
  final double? elevation;

  /// The internal padding for the button.
  final EdgeInsetsGeometry? padding;

  /// Defines how compact the button's layout will be.
  final VisualDensity? visualDensity;

  /// How much space to place between each rating button in a run in the main axis.
  ///
  ///For example, if [spacing] is 10.0, the each rating button will be spaced at least 10.0 logical pixels apart in the main axis.
  final double spacing;

  /// How much space to place between the each rating button themselves in the cross axis.

  /// For example, if [runSpacing] is 10.0, the each rating button will be spaced at least 10.0 logical pixels apart in the cross axis.

  final double runSpacing;

  /// How the each rating button within a run should be placed in the main axis.
  ///
  ///For example, if [alignment] is [WrapAlignment.center], the each rating button in each run are grouped together in the center of their run in the main axis.
  ///
  ///Defaults to [WrapAlignment.start].

  final WrapAlignment alignment;

  /// How the each rating button within a run should be aligned relative to each other in the cross axis.
  ///
  ///For example, if this is set to [WrapCrossAlignment.end], and the [direction] is [Axis.horizontal], then the  each rating button within each run will have their bottom edges aligned to the bottom edge of the run.
  ///
  ///Defaults to [WrapCrossAlignment.start].
  final WrapCrossAlignment crossAxisAlignment;

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
    this.spacing = 0.0,
    this.runSpacing = 0.0,
    this.alignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
  });

  RatingButtonThemeData copyWith({
    double? minWidth,
    double? height,
    TextStyle? activeTextStyle,
    TextStyle? inActiveTextStyle,
    Color? inActiveColor,
    Color? activeColor,
    Color? textColor,
    Color? highlightColor,
    Color? splashColor,
    ShapeBorder? shape,
    double? elevation,
    EdgeInsetsGeometry? padding,
    VisualDensity? visualDensity,
    double? spacing,
    double? runspacing,
    WrapAlignment? alignment,
    WrapCrossAlignment? crossAxisAlignment,
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
      alignment: alignment ?? this.alignment,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      runSpacing: runSpacing,
      spacing: spacing ?? this.spacing,
    );
  }

  static RatingButtonThemeData get defaultTheme => RatingButtonThemeData(
        activeTextStyle: TextStyle(fontSize: 14),
        minWidth: 40,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            side: BorderSide(width: .8, color: Colors.grey[300]!)),
        elevation: 0,
      );

  static RatingButtonThemeData roundedBorder(
          {BorderSide side = BorderSide.none,
          BorderRadiusGeometry borderRadius = BorderRadius.zero}) =>
      defaultTheme.copyWith(
          shape:
              RoundedRectangleBorder(side: side, borderRadius: borderRadius));

  static RatingButtonThemeData outlinedBorder({
    Color borderColor = Colors.grey,
    double borderWidth = 1.0,
    BorderStyle borderStyle = BorderStyle.solid,
    double borderRadius = 4.0,
  }) =>
      defaultTheme.copyWith(
          inActiveColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: borderColor,
                width: borderWidth,
                style: borderStyle,
              ),
              borderRadius: BorderRadius.circular(borderRadius)));

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
