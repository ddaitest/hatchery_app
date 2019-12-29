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
import 'package:hatchery/manager/beans.dart';
import 'dart:collection';

class SplashManager extends ChangeNotifier {
  Timer timer;
  bool _agreementData;
  bool get AgreementData => _agreementData;

  List<AdListInfo> _adLists = [];

  UnmodifiableListView<AdListInfo> get AdLists =>
      UnmodifiableListView(_adLists);

  int get total => _adLists.length;
  int get ResultCode => resultCode;

  int countdownTime = SPLASH_TIME;
  var parsed;
  var newParsed;
  var result;
  var newResultData;
  int resultCode;
  String statesMessage;
  String _responseData;

  SplashManager() {
    getLocalData();
    queryAdData();
  }

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
  }

  /// 存广告json
  saveAdJson(AdJson) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('splashAd_json', AdJson);
  }

  /// 取广告json
  getAdJson(AdJson) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _responseData = sharedPreferences.getString(AdJson) ?? null;
    return _responseData;
  }

  /// 开屏倒计时
  startCountdown() {
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
    Response response = await Api.querySplashList();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    result = response.data;
    _responseData = sharedPreferences.getString('splashAd_json') ?? null;
    if (_responseData != null) {
      parsed = json.decode(_responseData);
      var resultData = parsed['result'][0];
      add(AdListInfo.fromJson(resultData));
      newParsed = json.decode(result);
      resultCode = newParsed['code'] ?? 0;
      statesMessage = parsed['info'] ?? null;
      var newResultData = newParsed['result'][0] ?? null;
      if (resultCode == 200 && statesMessage == 'OK' && newResultData != null) {
        print('LC resultData-> $newResultData');
        saveAdJson(newResultData);
      }
    } else {
      parsed = json.decode(result);
      resultCode = parsed['code'] ?? 0;
      statesMessage = parsed['info'] ?? null;
      var resultData = parsed['result'][0] ?? null;
      if (resultCode == 200 && statesMessage == 'OK' && resultData != null) {
        print('LC resultData-> $resultData');
        saveAdJson(newResultData);
        add(AdListInfo.fromJson(resultData));
      }
    }
  }

  void add(AdListInfo item) {
    _adLists.add(item);
    notifyListeners();
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
