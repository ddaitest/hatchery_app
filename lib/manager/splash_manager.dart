import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hatchery/common/widget/webview_common.dart';
import 'package:hatchery/configs.dart';
import 'dart:convert' as convert;
import 'package:hatchery/common/api.dart';
import 'package:flutter/services.dart';
import 'package:hatchery/api/entity.dart';
import 'dart:collection';
import 'package:hatchery/common/tools.dart';
import 'package:hatchery/configs.dart';

class SplashManager extends ChangeNotifier {
  Timer? _timer;

  List<Advertising> _splashAdLists = [];

  UnmodifiableListView<Advertising> get splashAdLists =>
      UnmodifiableListView(_splashAdLists);

  int _countdownTime = SPLASH_TIME;

  int get countdownTime => _countdownTime;
  String? _responseResult;
  List<dynamic>? _finalParse;

  SplashManager(BuildContext context) {
    _getSplashAdData(context);
    // sharedDeleteData('showUpgradeCard');
    // queryAdData();
  }

  List<String>? _getSplashAdData(context) {
    _responseResult = SP.getString(SPLASH_AD_RESPONSE_KEY);
    if (_responseResult != null) {
      _finalParse = jsonDecode(_responseResult!);
      print("DEBUG=> _finalParse ${_finalParse}");
      _finalParse!.forEach((element) {
        addSplashAdData(Advertising.fromJson(element));
      });
      if (_splashAdLists.isEmpty) {
        routeHomePage(context);
      } else {
        startCountdown(context);
      }
    } else {
      _splashAdLists = [];
      routeHomePage(context);
    }
  }

  void addSplashAdData(Advertising item) {
    _splashAdLists.add(item);
  }

  /// UI动作 点击广告
  void clickAD(BuildContext context) {
    _stopCountdown();
    if (_splashAdLists.isNotEmpty)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                WebViewPage(_splashAdLists[0].redirectUrl, '/')),
      );
  }

  /// UI动作 跳过倒计时
  void skip(BuildContext context) {
    _stopCountdown();
    routeHomePage(context);
  }

  void routeHomePage(context) async {
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  /// 开屏倒计时
  Future startCountdown(BuildContext context) async {
    final timeUp = (Timer timer) {
      print("LC countdownTime ==> $_countdownTime");
      if (_countdownTime < 2) {
        _stopCountdown();
        routeHomePage(context);
      } else {
        _countdownTime--;
        notifyListeners();
      }
    };
    _timer = Timer.periodic(Duration(seconds: 1), timeUp);
  }

  /// 停止倒计时
  _stopCountdown() async {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _stopCountdown();
    super.dispose();
  }
}
