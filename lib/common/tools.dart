import 'dart:io';
import 'package:flutter_native_image/flutter_native_image.dart';

Future compressionImage(filePath) async {
  ImageProperties properties =
      await FlutterNativeImage.getImageProperties(filePath);
  File compressedFile = await FlutterNativeImage.compressImage(filePath,
      quality: 100,
      targetWidth: 720,
      targetHeight: (properties.height * 720 / properties.width).round());
  return compressedFile.path;
}
