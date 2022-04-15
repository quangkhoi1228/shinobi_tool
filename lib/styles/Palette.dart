import 'package:flutter/material.dart';

class Palette {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: Colors.blue,
    brightness: Brightness.light,
    accentColor: Colors.blue,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
    scaffoldBackgroundColor: Colors.white,
  );

  /* Dark theme settings */
  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: Colors.blue,
    brightness: Brightness.dark,
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
    scaffoldBackgroundColor: Color(0xFF131313),
  );
}
