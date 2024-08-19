import 'package:flutter/material.dart';
import 'package:themesplus/themesplus.dart';

void main() async {
  await ThemesUtil.init(
    themes: [
      AppTheme(
        themeName: 'Light Theme',
        description: 'The default light theme.',
        id: "0",
        themeData: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.red, brightness: Brightness.light),
        ),
      ),
      AppTheme(
        themeName: 'Dark Theme',
        description: 'The default dark theme.',
        id: "1",
        themeData: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue, brightness: Brightness.dark),
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
    return ThemeListener(
      builder: (context, value, child) {
        return MaterialApp(
          theme: AppTheme.data,
          home: Scaffold(
            backgroundColor: AppTheme.colors.surface,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      'Current Theme: ${ThemesUtil.currentTheme!.value.themeName}'),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () {
                      ThemesUtil.switchTheme();
                      print(
                          'Switched Theme to ${ThemesUtil.currentTheme!.value.themeName}');
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
