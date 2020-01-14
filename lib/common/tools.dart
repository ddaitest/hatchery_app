import 'dart:io';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future compressionImage(filePath) async {
  ImageProperties properties =
      await FlutterNativeImage.getImageProperties(filePath);
  File compressedFile = await FlutterNativeImage.compressImage(filePath,
//      quality: 100,  默认70
      targetWidth: properties.width,
      targetHeight: properties.height);
  return compressedFile;
}

setLocalDataString(key, value) async {
  SharedPreferences.getInstance().then((info) {
    info.setString(key, value);
  });
}

getLocalDataString(key) async {
  SharedPreferences.getInstance().then((info) {
    return info.getString(key) ?? null;
  });
}
