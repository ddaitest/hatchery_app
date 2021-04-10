import 'dart:io';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:hatchery/flavors/default.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future compressionImage(filePath) async {
  ImageProperties properties =
      await FlutterNativeImage.getImageProperties(filePath);
  final width = properties.width;
  final height = properties.height;
  if (width == null || height == null) {
    return null;
  } else {
    File compressedFile = await FlutterNativeImage.compressImage(filePath,
//      quality: 100,  默认70
        targetWidth: width,
        targetHeight: height);
    return compressedFile.path;
  }
}

class SP {
  static late SharedPreferences sp;

  static Future init() async {
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
