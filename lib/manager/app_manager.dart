import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:hatchery/common/api.dart';
import 'package:hatchery/manager/beans.dart';
import 'package:flutter/material.dart';

class AppManager extends ChangeNotifier {
  int _m = 0;

  int get m => _m;

//  void apptest() {
//    _m++;
//    notifyListeners();
//  }
//
//  static final AppManager _instance = AppManager._create();
//
//  factory AppManager() => _instance;
//
//  AppManager._create() {
//    print("MainManager init $hashCode");
//  }
//
  ///服务tab顶部
  var ServiceTopMap = {
    "0": "物业服务",
    "1": "家电维修",
    "2": "保姆月嫂",
    "3": "洗车",
    "4": "便民服务",
    "5": "房屋租售",
    "6": "各种服务",
    "7": "其他",
  };

  ///服务tab数据
  queryServiceData() async {
    Response response = await API.queryServiceList();
    final parsed = json.decode(response.data);
    var resultCode = parsed['code'] ?? 0;
    if (resultCode == 200 && parsed != null) {
      return parsed;
    }
  }
}
