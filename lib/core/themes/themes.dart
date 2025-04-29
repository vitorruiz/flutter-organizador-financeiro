import 'package:flutter/material.dart';

part 'color_schemes.g.dart';

ThemeData getLightTheme(ColorScheme? dynamicColorScheme) => ThemeData(
      useMaterial3: true,
      colorScheme: dynamicColorScheme ?? _lightColorScheme,
    );

ThemeData getDarkTheme(ColorScheme? dynamicColorScheme) => ThemeData(
      useMaterial3: true,
      colorScheme: dynamicColorScheme ?? _darkColorScheme,
    );