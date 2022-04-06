import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shinobi_tool/pages/modules/home/home.dart';

void main() => runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    /* light theme settings */
    theme: ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Colors.white,
      brightness: Brightness.light,
      accentColor: Colors.black,
      accentIconTheme: IconThemeData(color: Colors.white),
      dividerColor: Colors.white54,
      scaffoldBackgroundColor: Colors.white,
    ),

    /* Dark theme settings */
    darkTheme: ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      accentColor: Colors.white,
      accentIconTheme: IconThemeData(color: Colors.black),
      dividerColor: Colors.black12,
      scaffoldBackgroundColor: Color(0xFF131313),
    ),

    /* ThemeMode.system to follow system theme,
         ThemeMode.light for light theme,
         ThemeMode.dark for dark theme */
    themeMode: ThemeMode.system,
    home: HomePage()));
