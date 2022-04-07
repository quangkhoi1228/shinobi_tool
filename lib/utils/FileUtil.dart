import 'dart:async' show Future;
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
}
