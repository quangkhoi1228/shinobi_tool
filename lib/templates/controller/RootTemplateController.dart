import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootTemplateController extends GetxController {
  var isDarkMode = true.obs;

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
}
