import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:hatchery/configs.dart';
import 'package:hatchery/business/splash/splash.dart';

class SplashManager extends ChangeNotifier {
  String _splashUrl = 'images/welcome.png';

  String get splashUrl => _splashUrl;

  String _splashTip = "泰达希尔\n暴风城\n";

  String get splashTip => _splashTip;

  Timer _timer;

  //倒计时数值
  var _countdownTime = 5;

  int get countdownTime => _countdownTime;
  Timer get timer => _timer;

  //倒计时方法
  startCountdown() {
    _countdownTime = SPLASH_TIME;
    final call = (timer) {
      print("LC => countDown###### $_countdownTime");
      if (_countdownTime <= 0) {
        _timer.cancel();
        SplashState().gotoHomePage();
      } else {
        _countdownTime--;
        notifyListeners();
      }
    };
    _timer = Timer.periodic(Duration(seconds: 1), call);
  }
}
