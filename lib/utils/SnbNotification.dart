import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shinobi_tool/styles/Css.dart';

class NotificationConfig {
  Color backgroundColor;
  Color colorText;

  NotificationConfig({required this.backgroundColor, required this.colorText});
}

class SnbNotification {
  static NotificationConfig errorConfig = NotificationConfig(
      backgroundColor: Get.theme.errorColor, colorText: Colors.white);
  static NotificationConfig infoConfig = NotificationConfig(
      backgroundColor: Get.theme.hintColor, colorText: Colors.black);
  static void show(String title, String message,
      {required NotificationConfig config}) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(Css.padding),
        backgroundColor: config.backgroundColor,
        colorText: config.colorText);
  }

  static void error(String message) {
    show("Error", message, config: errorConfig);
  }

  static void info(String message) {
    show("Info", message, config: infoConfig);
  }
}
