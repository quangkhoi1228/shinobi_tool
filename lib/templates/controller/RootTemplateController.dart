import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shinobi_tool/routes/Routes.dart';
import 'package:shinobi_tool/utils/LocalStorage.dart';

class RootTemplateController extends GetxController {
  var isDarkMode = true.obs;
  static LocalStorage storage = LocalStorage();
  static var hasLoadLastPage = false.obs;

  @override
  void onInit() {
    isDarkMode.value = true;
    super.onInit();
  }

  void toggleDarkMode() {
    isDarkMode.value = Get.isDarkMode;

    if (Get.isDarkMode) {
      Get.changeTheme(ThemeData.light());
    } else {
      Get.changeTheme(ThemeData.dark());
    }
  }

  static void setCurrentPage(String name) {
    storage.setItem('currentPage', name);
  }

  static Future<String> getCurrentPage() async {
    return storage.getJsonAllData().then((value) {
      if (value.containsKey('currentPage')) {
        return value.getString('currentPage');
      } else {
        return Routes.homePage;
      }
    });
  }
}
