import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shinobi_tool/routes/Routes.dart';
import 'package:shinobi_tool/styles/Palette.dart';
import 'package:shinobi_tool/utils/LocalStorage.dart';

import 'modules/Home/HomePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initLoad();
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Palette.lightTheme,
      darkTheme: Palette.darkTheme,
      themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      getPages: Routes.getRoutes(),
      initialRoute: Routes.homePage,
      unknownRoute: Routes.getPageByName(Routes.notFoundPage),
      home: HomePage()));
}


void initLoad() {
  PackageInfo.fromPlatform().then((packageInfo) {
    LocalStorage.defaultInfo.set('appName', packageInfo.appName);
    LocalStorage.defaultInfo.set('buildNumber', packageInfo.buildNumber);
    LocalStorage.defaultInfo.set('buildSignature', packageInfo.buildSignature);
    LocalStorage.defaultInfo.set('packageName', packageInfo.packageName);
    LocalStorage.defaultInfo.set('version', packageInfo.version);
  });
}
