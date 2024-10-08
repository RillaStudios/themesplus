<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

ThemesPlus is a Flutter package that helps you easily add and manage themes throughout your flutter app.

<img src="https://raw.githubusercontent.com/RillaStudios/themesplus/2fa28a8ba764dc0ab5a4eee18023cc299e920dc8/resources/exampleClip.gif" alt="Themes Example Gif" style="width: 50%;">

## Features

The following is a list of features this package provides:

- Dynamically switch themes throughout your app.
- Add an unlimited amount of themes to your app.
- Quickly and easily call theme attributes when building the UI.
- Save theme to user settings so theme will be automatically set when app is opened.

## Switching Themes

To switch a theme call the ThemesUtil.switchTheme() method.

<h4>Method Parameters</h4>

- themeName - Will switch the theme to the given theme name.
- themeId - Will switch the theme to the given id.
- saveToSettings - Will indicate weather or not to save the newly switched theme into user settings. By default this is true and does not need to be set unless you don't wish to save, in which case this parameter should be false.

- Note: themeName and themeId cannot both be set, only one can be provided in the parameters.

```dart
FilledButton(
    onPressed: () {
    ThemesUtil.switchTheme();
    debugPrint('Switched Theme to ${ThemesUtil.currentTheme!.value.themeName}');
    },
    child: const Text('Switch Theme'),
),
```

## 📋 Getting started

To use this package, add ThemesPlus as a dependency in your pubspec.yaml file.

```yaml
dependencies:
  themesplus: ^1.0.0
```

Import the package

```dart
import 'package:themesplus/themesplus.dart';
```

## Example

The following code sample is a basic sample on how to use this package:

```dart
import 'package:flutter/material.dart';
import 'package:themesplus/themesplus.dart';

///
/// Example of how to use the ThemesPlus package.
///
/// ### Notes:
///
/// - Ensure you have the ThemesPlus package imported in your pubspec.yaml file.
/// - Ensure you use the [ThemesUtil.init] method in the main method to initialize the themes.
/// - Ensure you convert the main method to an async method using the `async` keyword.
/// - Ensure you await the [ThemesUtil.init] method.
/// - Ensure that method [WidgetsFlutterBinding.ensureInitialized] is called before the [ThemesUtil.init] method.
///
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ThemesUtil.init(
    /// A list of all the themes for the app.
    ///
    /// This list cannot be empty. Every theme must have a unique name and id.
    /// The first theme in the list is set as the current theme (default).
    ///
    /// The current theme can be accessed using [ThemesUtil.currentTheme].
    ///
    /// ### Recommended:
    ///
    /// - Create a separate file to store the themes and set them to the themes list.
    themes: [
      AppTheme(
        themeName: 'Red Theme',
        description: 'A red theme with auto system brightness.',
        id: "redTheme",
        themeData: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red, brightness: AppTheme.systemBrightness),
        ),
      ),
      AppTheme(
        themeName: 'Blue Theme',
        description: 'A blue theme with dark brightness.',
        id: "blueTheme",
        themeData: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
        ),
      ),
    ],
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// The [ThemeListener] widget listens to theme changes and rebuilds the child widget.
    /// This widget should be used at the root of the app. It is used to listen to theme changes.
    /// The [onThemeChanged] callback is called when the theme changes. It is optional and can
    /// be used to add custom features when a user switches a theme.
    ///
    /// The [child] widget is required.
    ///
    /// It is important to set the theme to [AppTheme.data] in the MaterialApp widget.
    ///
    return ThemeListener(
      builder: (context, value, child) {
        return MaterialApp(
          theme: AppTheme.data, //Important to set the theme to AppTheme.data
          home: Scaffold(
            backgroundColor: AppTheme.colors!.surface,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Current Theme: ${ThemesUtil.currentTheme!.value.themeName}'),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () {
                      ThemesUtil.switchTheme();
                      debugPrint('Switched Theme to ${ThemesUtil.currentTheme!.value.themeName}');
                    },
                    child: const Text('Switch Theme'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
```

## ℹ️ Additional information

<h3>🪄 Feature request?</h3>

Have an idea to make this package even better? Tell us on the <a href="https://github.com/RillaStudios/themesplus/discussions">ThemesPlus discussion page (GitHub)</a>

<h3>🪲 Found a bug?</h3>

Please report all bugs or issues on the <a href="https://github.com/RillaStudios/themesplus/issues">ThemesPlus issues page (GitHub)</a>

We encourage you to report anything package related to the GitHub repository pages as any and all input will help make this package even better in future versions!

## 🚀 Support

Enjoying this package? Consider supporting my work. Your contributions will allow me to keep creating and sharing valuable content and innovative projects.

<a href="https://www.buymeacoffee.com/izaakford" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="60px" width="217px"></a>
