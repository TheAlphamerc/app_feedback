part of 'theme.dart';

class TextStyles {
  static TextStyle bodyText14(BuildContext context) =>
      context.textTheme.bodyText1!.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: context.isDarkMode ? Color(0xFFC5C3C3) : Color(0xff424242));

  static TextStyle bodyText15(BuildContext context) =>
      bodyText14(context).copyWith(
        fontSize: 15,
      );

  static TextStyle headline14(BuildContext context) =>
      bodyText15(context).copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      );

  static TextStyle headline16(BuildContext context) =>
      headline14(context).copyWith(
        fontSize: 16,
      );

  static TextStyle headline18(BuildContext context) =>
      headline14(context).copyWith(
        fontSize: 18,
      );

  static TextStyle subtitle14(BuildContext context,
          {FontWeight fontWeight = FontWeight.w400}) =>
      bodyText14(context).copyWith(
        fontWeight: fontWeight,
        color: context.isDarkMode ? Color(0xff919191) : Color(0xff424242),
      );
}
