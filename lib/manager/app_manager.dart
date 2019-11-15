import 'package:flutter/foundation.dart';

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
  //周边顶部
  var NearbyTopMap = {
    "0": "物业服务",
    "1": "家电维修",
    "2": "保姆月嫂",
    "3": "洗车",
    "4": "便民服务",
    "5": "房屋租售",
    "6": "各种服务",
    "7": "其他",
  };
}
