import 'package:flutter/material.dart';
import 'theme.dart';

class DynamicColorTheme extends MaterialTheme {
  DynamicColorTheme(super.textTheme);

  ThemeData lightDynamicColorTheme(ColorScheme? dynamicColorScheme) =>
      theme(dynamicColorScheme ?? MaterialTheme.lightScheme());

  ThemeData darkDynamicColorTheme(ColorScheme? dynamicColorScheme) =>
      theme(dynamicColorScheme ?? MaterialTheme.darkScheme());
}
