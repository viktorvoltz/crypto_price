import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.white,
  dividerColor: Colors.black12,
  iconTheme: const IconThemeData(color: Colors.white),
  primaryIconTheme: const IconThemeData(color: Colors.black),
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: Colors.white,
  ),
  //primaryColor: Colors.white,
  brightness: Brightness.light,
  textTheme: const TextTheme(
    subtitle1: TextStyle(color: Colors.black)
  ),
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: Colors.black,
  dividerColor: Colors.grey,
  iconTheme: const IconThemeData(color: Colors.black),
  primaryIconTheme: const IconThemeData(color: Colors.black),
);
