part of 'package:themesplus/themesplus.dart';

/// A getter class to access the current theme's data quickly
/// and easily without having to use Theme.of(context).
///
/// This class is abstract and cannot be instantiated.
///
///
abstract class ActiveTheme {
  ///A variable to access the current theme's color scheme.
  ///A color scheme must be defined in the ThemeData to access this variable.
  ///
  static final colors = ThemesUtil.currentTheme!.value.themeData.colorScheme;

  ///A variable to access the current theme's text theme.
  ///A text theme must be defined in the ThemeData to access this variable.
  ///
  static final text = ThemesUtil.currentTheme!.value.themeData.textTheme;

  ///A variable to access the current themes data.
  ///
  static final data = ThemesUtil.currentTheme!.value.themeData;
}
