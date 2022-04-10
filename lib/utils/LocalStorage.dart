import 'dart:convert';
import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider_macos/path_provider_macos.dart';

import 'SnbJson.dart';

class LocalStorage {
  //Creating singleton of LocalStorage
  static SnbJson defaultInfo = SnbJson.newJson();
  static LocalStorage? obj;
  static instance() {
    if (obj == null) obj = LocalStorage();
    return obj;
  }

//Getting document path using path provider package
  Future<String> get _localPath async {
    String saveDataPath = "";
    if (Platform.isMacOS) {
      String? directory =
          await PathProviderMacOS().getApplicationDocumentsPath();
      if (directory != null) {
        saveDataPath = directory;
      }
    }
    return saveDataPath;
  }

  static dynamic getDataKey(Map data, String key) {
    if (data.containsKey(key)) {
      return data[key];
    } else {
      print('localStorage is not contains key "$key"');
      return null;
    }
  }

//getting instance of file using localPath
  Future<File> get _localFile async {
    final path = await _localPath;
    String appName =
        defaultInfo.getString('appName').toLowerCase().replaceAll(' ', '_');

    return File('$path/${appName}_data.json');
  }

//function to write data in file
  void writeData(Map<String, dynamic> data) async {
    File file = await _localFile;
    Map<String, dynamic> tempMap;

    if (await file.exists()) {
      tempMap = json.decode(file.readAsStringSync());
      tempMap.addAll(data);
      file.writeAsStringSync(json.encode(tempMap));
    } else {
      file.writeAsStringSync(json.encode(data));
    }
  }

  void setItem(String key, dynamic value) async {
    File file = await _localFile;
    Map<String, dynamic> newItem = {key: value};
    Map<String, dynamic> tempMap;
    if (await file.exists()) {
      tempMap = json.decode(file.readAsStringSync());
      tempMap.addAll(newItem);
      file.writeAsStringSync(json.encode(tempMap));
    } else {
      file.writeAsStringSync(json.encode(newItem));
    }
  }

  Future<SnbJson> getJsonAllData() async {
    return getAll().then((data) {
      return SnbJson(data);
    });
  }

  Future<dynamic> getItem(String key) async {
    File tempFile = await _localFile;
    if (await tempFile.exists()) {
      Map data = json.decode(tempFile.readAsStringSync());
      if (data.containsKey(key)) {
        return data[key];
      } else {
        return null;
      }
    } else
      return null;
  }

  //Function to get all the data in json format
  Future<Map> getAll() async {
    File tempFile = await _localFile;
    if (await tempFile.exists()) {
      return json.decode(tempFile.readAsStringSync());
    } else {
      return SnbJson.newJson().data;
    }
  }

//To delete data if exist in the file
  Future deleteData(
      String dataToDelete, Function onDelte, Function ifNotExist) async {
    File tempFile = await _localFile;
    if (!tempFile.existsSync()) {
      ifNotExist();
    } else {
      Map data = json.decode(tempFile.readAsStringSync());
      var result = data.remove(dataToDelete);
      if (result == null) {
        ifNotExist();
      } else {
        tempFile.writeAsStringSync(json.encode(data));
        onDelte();
      }
    }
  }

  //To delete data if exist in the file
  void removeItem(String key) async {
    File tempFile = await _localFile;
    if (!tempFile.existsSync()) {
      print('not exist data ');
    } else {
      Map data = json.decode(tempFile.readAsStringSync());
      data.remove(key);
    }
  }
}
