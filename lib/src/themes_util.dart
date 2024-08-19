part of 'package:themesplus/themesplus.dart';

/// A utility class to manage themes and the package.
///
/// Themes can be switched using [ThemesUtil.switchTheme].
/// The current theme can be accessed using [ThemesUtil.currentTheme].
/// The list of all themes can be accessed using [ThemesUtil.appThemes].
///
class ThemesUtil {
  /// A list of all the themes for the app.
  ///
  /// This list is initialized using [ThemesUtil.init].
  /// This list cannot be empty. Every theme must have a unique name or id.
  static List<AppTheme> appThemes = [];

  /// The current theme of the app.
  /// This is a [ValueNotifier] that can be listened to.
  ///
  /// The current theme can be changed using [ThemesUtil.switchTheme].
  ///
  static ValueNotifier<AppTheme>? currentTheme;

  /// Initializes the themes for the app.
  /// This method must be called before using any other method in this class.
  ///
  /// ### Parameters:
  ///
  /// - The [themes] list cannot be empty.
  ///
  /// ### Notes:
  /// - Every theme must have a unique name or id.
  /// - The first theme in the list is set as the current theme (default).
  /// - The current theme can be accessed using [ThemesUtil.currentTheme].
  /// - The current theme can be changed using [ThemesUtil.switchTheme].
  ///
  static Future<void> init({required List<AppTheme> themes}) async {
    /// Assert the themes list is not empty.
    assert(themes.isNotEmpty, 'Themes list cannot be empty.');

    /// Check for unique theme IDs
    final themeIds = themes.map((theme) => theme.id).toSet();
    if (themeIds.length != themes.length) {
      throw ArgumentError('All themes must have unique IDs.');
    }

    /// A set to store the theme names.
    Set<String> themeNames = {};

    /// Check if every theme has a unique name or id.
    for (AppTheme theme in themes) {
      if (!themeNames.add(theme.themeName) ||
          !themeNames.add(theme.id.toString())) {
        throw Exception(
            'Theme ${theme.themeName} already exists. Every theme must have a unique name.');
      }
    }

    /// Set the themes list.
    appThemes = themes;

    /// Load the theme settings from the shared preferences.
    /// If the theme settings are not found, set the first theme as the default theme.

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? themeSettings = prefs.getString('themeSettings');

    if (themeSettings != null) {
      Map<String, dynamic> themeSettingsMap = jsonDecode(themeSettings);

      String themeId = themeSettingsMap['themeId'];

      AppTheme? savedTheme = appThemes.firstWhere(
          (element) => element.id == themeId,
          orElse: () => appThemes.first);

      currentTheme = ValueNotifier(savedTheme);
    } else {
      currentTheme = ValueNotifier(appThemes.first);
    }
  }

  /// Switches the theme of the app.
  ///
  /// ### Parameters:
  ///
  /// - [themeName] is the name of the theme to switch to.
  /// - [themeId] is the id of the theme to switch to.
  /// - [saveToSettings] is a boolean to save the theme to the shared preferences.
  ///  The default value is true. Must be set to false if the theme should not be saved.
  ///
  /// - Only one of [themeName] or [themeId] can be provided.
  ///
  /// ### Notes:
  ///
  /// - If [themeName] or [themeId] is provided, the theme is switched to that theme.
  /// - If neither is provided, the theme is switched to the next theme in the list.
  /// - If the current theme is the last theme in the list, the theme is switched to the first theme.
  /// - Throws an exception if the theme is not found.
  static Future<void> switchTheme(
      {String? themeName, String? themeId, bool? saveToSettings}) async {
    /// Assert only one of themeName or themeId is provided.
    assert(!(themeName != null && themeId != null),
        'Only one of themeName or themeId can be provided.');

    /// Check if the theme name or theme id is provided.
    if (themeName != null || themeId != null) {
      /// Check if the theme exists.
      if (!appThemes.any((element) {
        return element.themeName == themeName || element.id == themeId;
      })) {
        /// If the theme is not found, the current theme is not changed
        /// and an exception is thrown.
        throw Exception('Theme not found.');
      }

      /// Get the theme.
      AppTheme theme = appThemes.firstWhere((element) {
        return element.themeName == themeName || element.id == themeId;
      });

      /// Set the current theme to the new theme.
      currentTheme!.value = theme;

      return;
    }

    ///If neither themeName nor themeId is provided, switch to the next theme.
    ///

    /// Get the current theme index in the appThemes list.
    int currentIndex = appThemes.indexOf(currentTheme!.value);

    /// If the current theme is the last theme in the list, switch to the first theme.
    if (currentIndex == appThemes.length - 1) {
      currentTheme!.value = appThemes.first;
    } else {
      /// Otherwise, switch to the next theme in the list.
      currentTheme!.value = appThemes[currentIndex + 1];
    }

    if (saveToSettings != false) {
      await saveThemeToSettings(currentTheme!.value.id);
    }

    return;
  }

  /// A method to save the theme to the shared preferences.
  /// This method is called when the theme is switched by
  /// default, but can be flagged to false in the [switchTheme]
  /// methods parameters. This method can be called manually to.
  ///
  /// ### Parameters:
  ///
  /// - [themeId] is the id of the theme to save.
  ///
  /// ### Notes:
  ///
  /// - The theme is saved to the shared preferences as a json string.
  /// - The theme settings are saved under the key 'themeSettings'.
  /// - The theme settings are saved as a map with the key 'themeId'.
  ///
  /// ### Example:
  ///
  /// ```dart
  /// await ThemesUtil.saveThemeToSettings('1');
  /// ```
  ///
  /// This saves the theme with the id '1' to the shared preferences.
  ///
  static Future<void> saveThemeToSettings(String themeId) async {
    Map<String, String> themeSettings = {
      'themeId': themeId,
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('themeSettings', jsonEncode(themeSettings));
  }

  /// A method to clear the theme settings from the shared preferences.
  /// This method can be called to clear the theme settings or reset the theme.
  ///
  /// ### Example:
  ///
  /// ```dart
  /// await ThemesUtil.clearThemeSettings();
  /// ```
  static Future<void> clearThemeSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('themeSettings');
  }

  /// A method to dispose the current theme.
  /// This method should be called when the app is closed.
  ///
  static void _dispose() {
    if (currentTheme != null) {
      currentTheme!.dispose();
    }
  }
}
