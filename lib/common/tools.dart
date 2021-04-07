import 'dart:io';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:hatchery/flavors/default.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future compressionImage(filePath) async {
  ImageProperties properties =
      await FlutterNativeImage.getImageProperties(filePath);
  File compressedFile = await FlutterNativeImage.compressImage(filePath,
//      quality: 100,  默认70
      targetWidth: properties.width,
      targetHeight: properties.height);
  return compressedFile.path;
}

class SP {
  static late  SharedPreferences sp;

  init() async {
    sp = await SharedPreferences.getInstance();
  }

  static set(String key, dynamic data) {
    switch (data.runtimeType) {
      case String:
        sp.setString(key, data);
        break;
      case bool:
        sp.setBool(key, data);
        break;
      case int:
        sp.setInt(key, data);
        break;
      case double:
        sp.setDouble(key, data);
        break;
      case List:
        sp.setStringList(key, data);
        break;
    }
  }

  static getString(String key) => sp.getString(key);

  static getBool(String key) => sp.getBool(key);

  static getDouble(String key) => sp.getDouble(key);

  static getInt(String key) => sp.getInt(key);

  static getStringList(String key) => sp.getStringList(key);
}

sharedAddAndUpdate(String key, Object dataType, Object data) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  switch (dataType) {
    case bool:
      sharedPreferences.setBool(key, data);
      break;
    case double:
      sharedPreferences.setDouble(key, data);
      break;
    case int:
      sharedPreferences.setInt(key, data);
      break;
    case String:
      sharedPreferences.setString(key, data);
      break;
    case List:
      sharedPreferences.setStringList(key, data);
      break;
    default:
      sharedPreferences.setString(key, data.toString());
      break;
  }
}

Future<Object?> sharedGetData(String key) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.get(key);
}

sharedDeleteData(String key) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.remove(key);
}
