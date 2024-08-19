part of 'package:themesplus/themesplus.dart';

/// The [ThemeListener] widget listens to theme changes and rebuilds the child widget.
/// This widget should be used at the root of the app. It is used to listen to theme changes.
///
/// ### Parameters:
///
/// - The [onThemeChanged] callback is called when the theme changes. It is optional.
/// - The [child] widget is required.
///
class ThemeListener extends StatefulWidget {
  /// The [child] widget.
  /// This is required.
  /// This widget is rebuilt when the theme changes.
  final Widget Function(BuildContext context, AppTheme value, Widget? child)
      builder;

  /// The callback that is called when the theme changes.
  /// This is optional.
  /// The new [AppTheme] is passed as a parameter to the callback.
  final Function(AppTheme)? onThemeChanged;

  const ThemeListener({super.key, this.onThemeChanged, required this.builder});

  @override
  State<ThemeListener> createState() => _ThemeListenerState();
}

class _ThemeListenerState extends State<ThemeListener> {
  /// Dispose the listener when the widget is disposed.
  @override
  void dispose() {
    ThemesUtil._dispose();
    super.dispose();
  }

  /// The build method for the [ThemeListener] widget.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemesUtil.currentTheme!,
      builder: (context, value, child) {
        AppTheme.data = value.themeData;
        AppTheme.colors = value.themeData.colorScheme;
        AppTheme.text = value.themeData.textTheme;

        print(AppTheme.data.colorScheme.primary);

        return widget.builder(context, value, child);
      },
    );
  }
}
