import 'dart:convert';

import 'Render.dart';
import 'package:flutter/cupertino.dart';

enum MapType { stringDynamic, dynamic }

class SnbJson {
  Map<String, dynamic> data = {};
  List<String> keys = [];
  SnbJson(var data) {
    this.data = (data.runtimeType == String) ? jsonDecode(data) : data;
    this.keys = this.data.keys.toList();
  }
  bool containsKey(String key) {
    return this.data.containsKey(key);
  }

  dynamic get(String key) {
    if (this.data.containsKey(key)) {
      return this.data[key];
    } else {
      print('json not contain key: $key, keys: ${this.keys}');
      return null;
    }
  }

  String getString(String key) {
    var value = get(key);
    return (value != null) ? Render.htmlUnescape(value.toString()) : '';
  }

  int getInt(String key) {
    var value = get(key);
    return (value != null) ? int.parse(value.toString()) : 0;
  }

  double getDouble(String key) {
    var value = get(key);
    return (value != null) ? double.parse(value.toString()) : 0.0;
  }

  List getList(String key) {
    var value = get(key);
    return (value != null) ? value : [];
  }

  SnbJson getJson(String key) {
    var value = get(key);
    return (value != null) ? SnbJson(value) : SnbJson.newJson();
  }

  bool getBool(String key) {
    var value = get(key);
    return (value != null) ? value.toString() == "true" : false;
  }

  Map<String, dynamic> getMap(String key) {
    var value = get(key);
    if (value != null) {
      return SnbJson(value.toString()).data;
    } else {
      return SnbJson.newJson().data;
    }
  }

  List<Widget> getListWidget(String key) {
    List<Widget> value = get(key);
    // ignore: unnecessary_null_comparison
    return (value != null) ? value : [];
  }

  void setBool(String key, bool value) {
    this.data[key] = (value.toString() == 'true');
  }

  void set(String key, dynamic value) {
    this.data[key] = value;
  }

  @override
  String toString() {
    return jsonEncode(this.data);
  }

  Map<String, dynamic> toJson() {
    return this.data;
  }

  void printJson({showType: false}) {
    print('_____________________________________________');

    print('{');
    this.data.entries.forEach((MapEntry element) {
      var type = element.value.runtimeType;
      var key = element.key;
      String value = element.value.toString();
      if (showType) {
        key = '($type) $key';
      }
      switch (type) {
        case String:
          value = '\"$value\"';
          break;
        case double:
        case int:
        case bool:
          break;
        default:
          value = '($type) ' + value;
          break;
      }
      print(' ' + key + ': ' + value + ',');
    });
    print('}');
    print('_____________________________________________');
  }

  static SnbJson newJson() {
    return SnbJson(Map<String, dynamic>.from({}));
  }
}
