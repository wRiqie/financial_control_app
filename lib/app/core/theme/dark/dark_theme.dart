import 'dark_color_scheme.dart';
import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  colorScheme: darkColorScheme,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  ),
);
