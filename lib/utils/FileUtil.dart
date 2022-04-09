import 'dart:async' show Future;
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

class FileUtil {
  static Future<String> readFileFromAsset(String path) async {
    print(path);
    return rootBundle.loadString(path).then((value) {
      if (value == null) {
        print('file $path not found');
        return "";
      } else {
        return value;
      }
    });
  }

  static Future<void> createFolder(String folderPath,
      {Function? onExist, Function? onNotExist}) async {
    final path = Directory(folderPath);

    if ((await path.exists())) {
      print("exist $folderPath");
      if (onExist != null) {
        onExist();
      }
    } else {
      print("create folder $folderPath");
      path.create();
      if (onNotExist != null) {
        onNotExist();
      }
    }
  }
}
