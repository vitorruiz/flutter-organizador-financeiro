import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:meu_patrimonio/core/color_schemes.dart';

import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightColorScheme, darkColorScheme) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: lightColorScheme ?? defaultLightColorScheme,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme ?? defaultDarkColorScheme,
            useMaterial3: true,
          ),
          home: const MyHomePage(),
        );
      },
    );
  }
}
