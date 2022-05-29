import 'package:flutter/material.dart';

import 'package:coingecko/src/utils/theme_pref.dart';

class ThemeProvider extends ChangeNotifier{
  ThemePreference themePreference = ThemePreference();

  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value){
    _darkTheme = value;
    themePreference.setDarkTheme(value);
    notifyListeners();
  }
}