part of 'theme.dart';

extension ThemeHelper on BuildContext {
  ThemeData get theme => Theme.of(this);
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get onPrimary => Theme.of(this).colorScheme.onPrimary;
  Color get surfaceColor => Theme.of(this).colorScheme.surface;
  TextTheme get textTheme => Theme.of(this).textTheme;
  Color? get bodyTextColor => Theme.of(this).textTheme.bodyText1!.color;
  Color get disabledColor => Theme.of(this).disabledColor;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}

extension TextStyleHelpers on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get white => copyWith(color: Colors.white);
  TextStyle primary(context) => copyWith(color: Theme.of(context).primaryColor);
  TextStyle onPrimary(context) =>
      copyWith(color: Theme.of(context).colorScheme.onPrimary);
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle size(double value) => copyWith(fontSize: value);
}

extension PaddingHelper on Widget {
  Padding get p16 => Padding(padding: EdgeInsets.all(16), child: this);

  /// Set all side padding according to `value`
  Padding p(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  /// Set all side padding according to `value`
  Padding pH(double value) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: value), child: this);

  Padding pV(double value) =>
      Padding(padding: EdgeInsets.symmetric(vertical: value), child: this);

  /// Horizontal Padding 16
  Padding get hP4 =>
      Padding(padding: EdgeInsets.symmetric(horizontal: 4), child: this);
  Padding get hP8 =>
      Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: this);
  Padding get hP16 =>
      Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: this);

  /// Vertical Padding 16
  Padding get vP16 =>
      Padding(padding: EdgeInsets.symmetric(vertical: 16), child: this);
  Padding get vP8 =>
      Padding(padding: EdgeInsets.symmetric(vertical: 8), child: this);
  Padding get vP12 =>
      Padding(padding: EdgeInsets.symmetric(vertical: 8), child: this);
  Padding get vP4 =>
      Padding(padding: EdgeInsets.symmetric(vertical: 4), child: this);

  ///Horrizontal Padding for Title
  Padding get hP30 =>
      Padding(padding: EdgeInsets.only(left: 30.0), child: this);

  ///Facebook/Google logo text Padding Helper
  Padding get vP5 =>
      Padding(padding: EdgeInsets.only(bottom: 5.5), child: this);

  /// Set right side padding according to `value`
  Padding pR(double value) =>
      Padding(padding: EdgeInsets.only(right: value), child: this);

  /// Set left side padding according to `value`
  Padding pL(double value) =>
      Padding(padding: EdgeInsets.only(left: value), child: this);

  /// Set Top side padding according to `value`
  Padding pT(double value) =>
      Padding(padding: EdgeInsets.only(top: value), child: this);

  /// Set bottom side padding according to `value`
  Padding pB(double value) =>
      Padding(padding: EdgeInsets.only(bottom: value), child: this);
}

extension Extended on Widget {
  Expanded get extended => Expanded(
        child: this,
      );
}

extension SizeHelper on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}
