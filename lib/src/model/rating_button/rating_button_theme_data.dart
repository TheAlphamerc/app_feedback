import 'package:flutter/material.dart';

class RatingButtonThemeData {
  final double minWidth;
  final double height;
  final Color activeColor;
  final Color inActiveColor;
  final TextStyle inActiveTextStyle;
  final Color highlightColor;
  final Color splashColor;
  final ShapeBorder shape;
  final double elevation;
  final TextStyle activeTextStyle;
  final EdgeInsetsGeometry padding;
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
