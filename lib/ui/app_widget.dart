import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

import '../utils/theme_util.dart';
import 'core/themes/dynamic_color_theme.dart';
import 'core/themes/theme.dart';
import 'home/home_screen.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _getApp(context);
  }

  MaterialApp _getApp(BuildContext context) {
    final Brightness brightness = View.of(context).platformDispatcher.platformBrightness;

    // Use with Google Fonts package to use downloadable fonts
    final TextTheme textTheme = createTextTheme(context, 'Exo 2', 'Exo 2');

    final MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'Finanças pessoais',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: const HomeScreen(),
    );
  }

  // ignore: unused_element
  DynamicColorBuilder _getDynamicColorApp(BuildContext context) {
    final Brightness brightness = View.of(context).platformDispatcher.platformBrightness;

    final TextTheme textTheme = createTextTheme(context, 'Exo 2', 'Exo 2');

    final DynamicColorTheme theme = DynamicColorTheme(textTheme);

    return DynamicColorBuilder(
      builder: (ColorScheme? lightColorScheme, ColorScheme? darkColorScheme) {
        return MaterialApp(
          title: 'Finanças pessoais',
          theme:
              brightness == Brightness.light
                  ? theme.lightDynamicColorTheme(lightColorScheme)
                  : theme.darkDynamicColorTheme(darkColorScheme),
          home: const HomeScreen(),
        );
      },
    );
  }
}
