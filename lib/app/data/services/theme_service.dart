import 'package:financial_control_app/app/core/theme/dark/dark_theme.dart';
import 'package:financial_control_app/app/core/theme/light/light_theme.dart';
import 'package:flutter/material.dart';

final appTheme = ThemeService();

class ThemeService extends ChangeNotifier {
  ThemeData currentTheme = darkTheme;

  void changeTheme() {
    currentTheme = currentTheme == darkTheme ? lightTheme : darkTheme;
    notifyListeners();
  }
}
