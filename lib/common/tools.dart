import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:hatchery/flavors/default.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info/device_info.dart';
import 'package:hatchery/flavors/Flavors.dart';

import '../config.dart';

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

  static delete(String key) => sp.remove(key);

  static getString(String key) => sp.getString(key);

  static getBool(String key) => sp.getBool(key);

  static getDouble(String key) => sp.getDouble(key);

  static getInt(String key) => sp.getInt(key);

  static getStringList(String key) => sp.getStringList(key);
}

class DeviceInfo {
  static late DeviceInfoPlugin deviceInfo;
  static late PackageInfo packageInfo;

  static Future init() async {
    deviceInfo = DeviceInfoPlugin();
    packageInfo = await PackageInfo.fromPlatform();
  }

  static setDeviceInfoToSP() {
    Map<String, dynamic>? _commonParamMap;
    if (Platform.isAndroid) {
      deviceInfo.androidInfo.then((deviceValue) {
        _commonParamMap = {
          "device_model": deviceValue.model,
          "phone_board": deviceValue.brand,
          "version": packageInfo.version,
          "vc": packageInfo.buildNumber,
          "package_name": packageInfo.packageName,
          "system_version": deviceValue.version.release,
          "android_id": deviceValue.androidId,
          "isPhysicalDevice": deviceValue.isPhysicalDevice
        };
        SP.set(SPKey.COMMON_PARAM_KEY, json.encode(_commonParamMap));
      });
    } else {
      deviceInfo.iosInfo.then((deviceValue) {
        _commonParamMap = {
          "device_model": deviceValue.utsname.machine,
          "phone_board": deviceValue.model,
          "version": packageInfo.version,
          "vc": packageInfo.buildNumber,
          "package_name": packageInfo.packageName,
          "system_version": deviceValue.systemVersion,
          "IDFV": deviceValue.identifierForVendor,
          "isPhysicalDevice": deviceValue.isPhysicalDevice
        };
        SP.set(SPKey.COMMON_PARAM_KEY, json.encode(_commonParamMap));
      });
    }
  }
}
