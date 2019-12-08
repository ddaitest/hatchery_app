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
  int resultCode;
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
    print("LC -> $_agreementData");
  }

  /// 存广告json
  saveAdJson(AdJson) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('ad_json', AdJson);
  }

  /// 取广告json
  getAdJson(AdJson) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _responseData = sharedPreferences.getString(AdJson) ?? null;
  }

  /// 开屏倒计时
  startCountdown() async {
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
    Response response = await Api.queryAdList();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _responseData = sharedPreferences.getString('ad_json') ?? null;
    if (response.data != null) {
      saveAdJson(response.data);
      print("LC responseData ==> $_responseData");
    }
    if (_responseData != null) {
      parsed = json.decode(_responseData);
      resultCode = parsed['code'] ?? 0;
      var resultData = parsed['data'] ?? null;
      add(AdListInfo.fromJson(resultData));
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
