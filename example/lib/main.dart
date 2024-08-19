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
          theme: AppTheme.data, //!Important to set the theme to AppTheme.data
          home: Scaffold(
            backgroundColor: AppTheme.colors!.surface,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Current Theme: ${ThemesUtil.currentTheme!.value.themeName}'),
                  const SizedBox(height: 20),
                  Text(
                    ThemesUtil.currentTheme!.value.description,
                    style: const TextStyle(fontSize: 20),
                  ),
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
