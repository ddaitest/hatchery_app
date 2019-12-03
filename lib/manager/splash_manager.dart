import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/configs.dart';
import 'package:dio/dio.dart';
import 'package:hatchery/common/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class SplashManager extends ChangeNotifier {
  String _splashUrl =
      'https://img.zcool.cn/community/012de8571049406ac7251f05224c19.png@1280w_1l_2o_100sh.png';
  String _splashGoto = 'https://www.sina.com.cn';

  bool _agreementData;
  bool get AgreementData => _agreementData;

  String get splashUrl => _splashUrl;
  String get splashGoto => _splashGoto;

  int countdownTime = SPLASH_TIME;

  SplashManager() {
    getLocalData();
    _startCountdown();
  }

  Timer timer;

  /// 设置协议是否同意标识
  setLocalData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('agreementData', true);
  }

  /// 获取协议是否同意标识
  getLocalData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _agreementData = sharedPreferences.getBool('agreementData') ?? null;
    notifyListeners();
    print("LC -> $_agreementData");
  }

  /// 开屏倒计时
  _startCountdown() async {
    final timeUp = (Timer timer) {
      print("LC countdownTime ==> $countdownTime");
      if (countdownTime < 1) {
        timer.cancel();
      } else {
        countdownTime--;
        notifyListeners();
      }
    };
    timer = Timer.periodic(Duration(seconds: 1), timeUp);
  }

  /// 获取开屏广告数据
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

  Future<void> exitApp() async {
    if (Platform.isAndroid) {
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } else if (Platform.isIOS) {
      exit(0);
    } else {
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      exit(0);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
