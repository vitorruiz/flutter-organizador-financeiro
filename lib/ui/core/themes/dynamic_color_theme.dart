import 'package:flutter/material.dart';
import 'package:meu_patrimonio/ui/core/themes/theme.dart';

class DynamicColorTheme extends MaterialTheme {
  DynamicColorTheme(super.textTheme);

  ThemeData lightDynamicColorTheme(ColorScheme? dynamicColorScheme) => theme(dynamicColorScheme ?? MaterialTheme.lightScheme());

  ThemeData darkDynamicColorTheme(ColorScheme? dynamicColorScheme) => theme(dynamicColorScheme ?? MaterialTheme.darkScheme());
}
