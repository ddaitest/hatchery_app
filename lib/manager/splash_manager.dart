import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/common/widget/webview_common.dart';
import 'package:hatchery/configs.dart';
import 'package:dio/dio.dart';
import 'package:hatchery/common/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:hatchery/manager/beans.dart';
import 'dart:collection';
import 'package:hatchery/common/tools.dart';

class SplashManager extends ChangeNotifier {
  /// 是否显示 协议确认UI
  bool _agreementData;

  Timer _timer;

  bool get agreementData => _agreementData;

  List<AdListInfo> _adLists = [];

  UnmodifiableListView<AdListInfo> get adLists =>
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

  SplashManager(BuildContext context) {
    _getLocalData();
    sharedDeleteData('showUpgradeCard');
    queryAdData();
    _startCountdown(context);
  }

  /// UI动作 点击广告
  void clickAD(BuildContext context) {
    _timer.cancel();
    MaterialPageRoute(
        builder: (context) => WebViewPage(_adLists[0].webUrl, '/'));
  }

  /// UI动作 跳过倒计时
  void skip(BuildContext context) {
    _timer.cancel();
    Navigator.pushReplacementNamed(context, '/');
  }

  /// UI动作 同意协议
  void agree(BuildContext context) {
    _setLocalData();
    Navigator.pushReplacementNamed(context, '/');
  }

  /// UI动作 同意协议
  void agreementUrl(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WebViewPage(AGREEMENT, null)),
    );
  }

  /// 设置协议是否同意标识
  void _setLocalData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('agreementData', true);
  }

  /// 获取协议是否同意标识
  _getLocalData() {
    SharedPreferences.getInstance().then((sp) {
      _agreementData = sp.getBool('agreementData') ?? true;
      if (!_agreementData) {
        _timer.cancel();
      }
      notifyListeners();
    });
  }

  /// 存广告json
  _saveAdJson(adJson) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('splashAd_json', adJson);
  }

  /// 取广告json
  getAdJson(adJson) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _responseData = sharedPreferences.getString(adJson) ?? null;
    return _responseData;
  }

  /// 开屏倒计时
  Future _startCountdown(BuildContext context) async {
    final timeUp = (Timer timer) {
      print("LC countdownTime ==> $countdownTime");
      if (countdownTime < 1) {
        timer.cancel();
        Navigator.pushReplacementNamed(context, '/');
      } else {
        countdownTime--;
        notifyListeners();
      }
    };
    _timer = Timer.periodic(Duration(seconds: 1), timeUp);
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
        print('LC resultData1-> $newResultData');
        _saveAdJson(result);
      }
    } else {
      parsed = json.decode(result);
      resultCode = parsed['code'] ?? 0;
      statesMessage = parsed['info'] ?? null;
      var newResultData = parsed['result'][0] ?? null;
      if (resultCode == 200 && statesMessage == 'OK' && newResultData != null) {
        print('LC resultData2-> $newResultData');
        _saveAdJson(result);
        add(AdListInfo.fromJson(newResultData));
      } else {
        add(AdListInfo.fromJson(json.decode(_responseData)['result'][0]));
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
