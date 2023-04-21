import '../../core/theme/dark/dark_theme.dart';
import '../../core/theme/light/light_theme.dart';
import 'package:flutter/material.dart';

final appTheme = ThemeService();

class ThemeService extends ChangeNotifier {
  bool isDark = true;

  ThemeData currentTheme() => isDark ? darkTheme : lightTheme;

  void changeTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}
