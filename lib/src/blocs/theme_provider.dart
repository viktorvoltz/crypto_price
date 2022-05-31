import 'package:flutter/material.dart';

import 'package:coingecko/src/utils/theme_pref.dart';
import 'package:coingecko/src/utils/theme_modes.dart';

class ThemeProvider extends ChangeNotifier{

  static ThemeData? _themeData;
  ThemeData getTheme() => _themeData!;

  ThemeProvider();

  /// sets the App's theme on start up.
  Future<void> setTheme()async{
    await ThemePreference.readData('themeMode').then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    ThemePreference.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    ThemePreference.saveData('themeMode', 'light');
    notifyListeners();
  }
}