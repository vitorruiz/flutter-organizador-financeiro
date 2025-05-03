import 'package:flutter/material.dart';
import 'package:meu_patrimonio/ui/core/themes/dynamic_color_theme.dart';
import 'package:meu_patrimonio/ui/core/themes/theme.dart';
import 'package:meu_patrimonio/ui/home/home_screen.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:meu_patrimonio/utils/theme_util.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _getApp(context);
  }

  _getApp(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    // Retrieves the default theme for the platform
    //TextTheme textTheme = Theme.of(context).textTheme;

    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(context, "Exo 2", "Exo 2");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(title: 'Finanças pessoais', theme: brightness == Brightness.light ? theme.light() : theme.dark(), home: const HomeScreen());
  }

  _getDynamicColorApp(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    // Retrieves the default theme for the platform
    //TextTheme textTheme = Theme.of(context).textTheme;

    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(context, "Exo 2", "Exo 2");

    DynamicColorTheme theme = DynamicColorTheme(textTheme);

    return DynamicColorBuilder(
      builder: (lightColorScheme, darkColorScheme) {
        return MaterialApp(
          title: 'Finanças pessoais',
          theme: brightness == Brightness.light ? theme.lightDynamicColorTheme(lightColorScheme) : theme.darkDynamicColorTheme(darkColorScheme),
          home: HomeScreen(),
        );
      },
    );
  }
}
