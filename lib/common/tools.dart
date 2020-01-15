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

Future<Object> sharedGetData(String key) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.get(key);
}

sharedDeleteData(String key) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.remove(key);
}
