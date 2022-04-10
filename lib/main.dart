import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shinobi_tool/routes/routes.dart';
import 'package:shinobi_tool/utils/LocalStorage.dart';

import 'modules/Home/HomePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PackageInfo.fromPlatform().then((packageInfo) {
    LocalStorage.defaultInfo.set('appName', packageInfo.appName);
    LocalStorage.defaultInfo.set('buildNumber', packageInfo.buildNumber);
    LocalStorage.defaultInfo.set('buildSignature', packageInfo.buildSignature);
    LocalStorage.defaultInfo.set('packageName', packageInfo.packageName);
    LocalStorage.defaultInfo.set('version', packageInfo.version);
  });

  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      /* light theme settings */
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        brightness: Brightness.light,
        accentColor: Colors.blue,
        accentIconTheme: IconThemeData(color: Colors.white),
        dividerColor: Colors.white54,
        scaffoldBackgroundColor: Colors.white,
      ),

      /* Dark theme settings */
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        brightness: Brightness.dark,
        accentColor: Colors.white,
        accentIconTheme: IconThemeData(color: Colors.black),
        dividerColor: Colors.black12,
        scaffoldBackgroundColor: Color(0xFF131313),
      ),

      /* ThemeMode.system to follow system theme,
         ThemeMode.light for light theme,
         ThemeMode.dark for dark theme */
      themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      getPages: Routes.getRoutes(),
      initialRoute: Routes.setupSourcePage,
      unknownRoute: Routes.getPageByName(Routes.notFoundPage),
      home: HomePage()));
}
