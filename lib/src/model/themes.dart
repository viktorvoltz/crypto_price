import 'dart:ui';
import 'package:flutter/material.dart';

class Themes{
  static ThemeData themeData (bool isDarkTheme, BuildContext context){
    return ThemeData(
      primarySwatch: isDarkTheme ? Colors.blueGrey : Colors.green,
      primaryColor: isDarkTheme ? Colors.black87 : Colors.white,

      accentColor: isDarkTheme ? Colors.black87 : Colors.white,

      backgroundColor: isDarkTheme ? Colors.black : const Color(0xffF1F5FB),

      indicatorColor: isDarkTheme ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
      buttonColor: isDarkTheme ? Colors.black : const Color(0xffF1F5FB),

      brightness: isDarkTheme ? Brightness.dark : Brightness.light,

      textSelectionColor: isDarkTheme ? Colors.white : Colors.black,

      /*textTheme: Theme.of(context).textTheme.copyWith(
        bodyText1: TextStyle(
          color: isDarkTheme ? Colors.white : Colors.black
        ),
        titleMedium: TextStyle(
          color: isDarkTheme ? Colors.white : Colors.black
        ),
        bodyText2: TextStyle(
          color: isDarkTheme ? Colors.white : Colors.black
        ),
        titleLarge: TextStyle(
          color: isDarkTheme ? Colors.white : Colors.black
        ),
        subtitle1: TextStyle(
          color: isDarkTheme ? Colors.white : Colors.black
        ),
        subtitle2: TextStyle(
          color: isDarkTheme ? Colors.white : Colors.black
        ),
        titleSmall: TextStyle(
          color: isDarkTheme ? Colors.white : Colors.black
        ),
      )*/
    );
  }
}