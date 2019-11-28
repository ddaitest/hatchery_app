import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/configs.dart';
import 'package:dio/dio.dart';
import 'package:hatchery/manager/beans.dart';
import 'package:hatchery/common/api.dart';

class SplashManager extends ChangeNotifier {
  String _splashUrl =
      'https://img.zcool.cn/community/012de8571049406ac7251f05224c19.png@1280w_1l_2o_100sh.png';
  String _splashGoto = 'https://www.sina.com.cn';

  String get splashUrl => _splashUrl;
  String get splashGoto => _splashGoto;

  int countdownTime = SPLASH_TIME;

  SplashManager() {
    _startCountdown();
  }

  Timer timer;

  /// 初始化
  _startCountdown() async {
    final timeUp = (Timer timer) {
      print("LC countdownTime ==> $countdownTime");
      if (countdownTime <= 1) {
        timer.cancel();
      } else {
        countdownTime--;
        notifyListeners();
      }
    };
    timer = Timer.periodic(Duration(seconds: 1), timeUp);
  }

  /// 初始化
  queryAdData() async {
    print("LC -> #####");
    Response response = await ApiForAD.queryAdList();
    final parsed = json.decode(response.data);
    print("LC -> $parsed");
    var resultCode = parsed['code'] ?? 0;
    var resultData = parsed['data']['splash_url'];
    if (resultCode == 200 && resultData != null) {
      print("LC -> $resultData");
//      _splashUrl = resultData
//          .map<ServiceListInfo>((json) => ServiceListInfo.fromJson(json))
//          .toList();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
