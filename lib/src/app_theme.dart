part of 'package:themesplus/themesplus.dart';

/// A class to represent a theme for the app.
///
/// ### Parameters:
///
/// - [id] is used to uniquely identify the theme.
///
/// - [themeName] is the name of the theme.
///
/// - [description] is optional and adds a description of the theme. It defaults to an empty string.
///
/// - [themeData] is the [ThemeData] for the theme.
///
/// - [useSystemBrightness] is optional and defaults to false.
/// If true, the theme will use the system brightness.
class AppTheme {
  /// The id of the theme.
  ///
  /// This is optional and can be used to uniquely identify the theme.
  final String id;

  /// The name of the theme.
  ///
  /// This is required and must be unique.
  final String themeName;

  /// A description of the theme.
  ///
  /// This is optional and defaults to an empty string.
  ///
  final String description;

  /// The [ThemeData] for the theme.
  /// This is required.
  ///
  late ThemeData themeData;

  /// If true, the theme will use the system brightness for the AppTheme.
  ///
  /// This is optional and defaults to false.
  final bool useSystemBrightness;

  /// An icon to represent the theme.
  ///
  /// This is optional.
  ///
  final Icon? icon;

  /// Constructor creates a new AppTheme.
  ///
  AppTheme({
    required this.id,
    required this.themeName,
    this.description = '',
    required this.themeData,
    this.useSystemBrightness = false,
    this.icon,
  }) {
    if (useSystemBrightness) {
      Brightness brightness =
          SchedulerBinding.instance.platformDispatcher.platformBrightness;

      themeData = themeData.copyWith(
        brightness: brightness,
      );
    }
  }

  ///A variable to access the current theme's color scheme.
  ///A color scheme must be defined in the ThemeData to access this variable.
  ///
  static ColorScheme colors =
      ThemesUtil.currentTheme!.value.themeData.colorScheme;

  ///A variable to access the current theme's text theme.
  ///A text theme must be defined in the ThemeData to access this variable.
  ///
  static TextTheme text = ThemesUtil.currentTheme!.value.themeData.textTheme;

  ///A variable to access the current themes data.
  ///
  static ThemeData data = ThemesUtil.currentTheme!.value.themeData;
}
