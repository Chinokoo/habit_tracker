import 'package:flutter/material.dart';
import 'package:habit_tracker/themes/dark_mode.dart';
import 'package:habit_tracker/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  //initial theme is light mode.
  ThemeData _themeData = lightMode;

  //get current theme.
  ThemeData get themeData => _themeData;

  //is current theme dark mode.
  bool get isDarkMode => _themeData == darkMode;

  //set current theme.
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  // toggle between light and dark mode.
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
