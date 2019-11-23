import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/configs.dart';
import 'package:hatchery/business/home/home.dart';
import 'package:hatchery/business/splash/splash.dart';

class SplashManager extends ChangeNotifier {
  String _splashUrl = 'images/welcome.png';

  String get splashUrl => _splashUrl;

  String _splashTip = "泰达希尔\n暴风城\n";

  String get splashTip => _splashTip;

  int countdownTime = SPLASH_TIME;

  SplashManager() {
    _startCountdown();
  }

  Timer timer;

  /// 初始化
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

//  @override
//  void dispose() {
//    timer.cancel();
//    super.dispose();
//  }
}
