import 'package:flutter/material.dart';
import 'package:shinobi_tool/styles/Css.dart';

class Palette {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: Colors.blue,
    brightness: Brightness.light,
    accentColor: Colors.blue,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme(
        primary: Css.color('#fca074'),
        primaryVariant: Css.isWhite,
        secondary: Css.color('#3b454e'),
        secondaryVariant: Css.isWhite,
        surface: Css.color('#3b454e'),
        background: Css.isWhite,
        error: Css.isDanger,
        onPrimary: Css.color('#3b454e'),
        onSecondary: Css.color('#3b454e'),
        onSurface: Css.isGrey,
        onBackground: Css.canvasColor,
        onError: Css.isDanger,
        brightness: Brightness.light),
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
