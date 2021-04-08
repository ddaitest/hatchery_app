import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hatchery/common/widget/webview_common.dart';
import 'package:hatchery/configs.dart';
import 'package:dio/dio.dart';
import 'package:hatchery/common/api.dart';
import 'package:flutter/services.dart';
import 'package:hatchery/api/entity.dart';
import 'dart:collection';
import 'package:hatchery/common/tools.dart';
import 'package:hatchery/configs.dart';

class SplashManager extends ChangeNotifier {
  /// 是否显示 协议确认UI
  bool? _isAgreeAgreementValue;

  Timer? _timer;

  bool? get isAgreeAgreementValue => _isAgreeAgreementValue;

  List<Advertising> _adLists = [];

  UnmodifiableListView<Advertising> get adLists =>
      UnmodifiableListView(_adLists);

  int get total => _adLists.length;

  // int get ResultCode => resultCode;

  int _countdownTime = SPLASH_TIME;

  int get countdownTime => _countdownTime;
  String? _responseResult;
  Map<dynamic, dynamic>? _finalParse;
  String? _splashAdImageUrl;
  String? _splashAdUrl;

  SplashManager(BuildContext context) {
    _getAdData();
    _startCountdown(context);
    // sharedDeleteData('showUpgradeCard');
    // queryAdData();
  }

  _getAdData() {
    _responseResult = SP.getString(AD_RESPONSE_KEY);
    if (_responseResult != null) {
      _finalParse = jsonDecode(_responseResult!);
      print("DEBUG=> @@@@@${_finalParse!['open_ad']['ad_media']}");
    } else {
      _splashAdImageUrl = '';
      _splashAdUrl = '';
    }
  }

  /// UI动作 点击广告
  void clickAD(BuildContext context) {
    _timer!.cancel();
    CupertinoPageRoute(
        builder: (context) => WebViewPage(_adLists[0].redirectUrl, '/'));
  }

  /// UI动作 跳过倒计时
  void skip(BuildContext context) {
    _timer!.cancel();
    Navigator.pushReplacementNamed(context, '/');
  }

  /// 开屏倒计时
  Future _startCountdown(BuildContext context) async {
    final timeUp = (Timer timer) {
      print("LC countdownTime ==> $_countdownTime");
      if (_countdownTime < 2) {
        _timer!.cancel();
        Navigator.pushReplacementNamed(context, '/');
      } else {
        _countdownTime--;
        notifyListeners();
      }
    };
    _timer = Timer.periodic(Duration(seconds: 1), timeUp);
  }

  @override
  void dispose() {
    if (_timer != null) _timer!.cancel();
    super.dispose();
  }
}
