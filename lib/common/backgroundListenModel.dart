import 'package:flutter/material.dart';
import 'package:hatchery/common/log.dart';
import 'dart:async';
import 'package:hatchery/routers.dart';
import 'package:hatchery/config.dart';
import 'package:hatchery/business/main_tab.dart';

class BackgroundListen with WidgetsBindingObserver {
  // Timer? backGroundTimer;
  // int? backGroundCountDown = TimeConfig.BACKGROUND_SPLASH_WAIT_TIME;
  // int? countDownNow;
  void init() {
    WidgetsBinding.instance?.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
  }

  // backGroundSplashCountDownTime() {
  //   /// 后台计时器
  //   backGroundTimer = Timer.periodic(Duration(seconds: 1), (timer) {
  //     countDownNow = backGroundCountDown! - 1;
  //     Log.log("backGroundCountDown_timer $countDownNow", color: LColor.YELLOW);
  //     if (countDownNow == 0) {
  //       backGroundTimer?.cancel();
  //       return;
  //     }
  //     backGroundCountDown = countDownNow;
  //   });
  // }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        Log.log("inactive #################", color: LColor.YELLOW);
        break;
      case AppLifecycleState.resumed: // 应用程序可见，前台
        Log.log("resumed #################", color: LColor.YELLOW);
        break;
      case AppLifecycleState.paused: // 应用程序不可见，后台
        Log.log("paused #################", color: LColor.YELLOW);
        break;
      case AppLifecycleState.detached:
        Log.log("detached #################", color: LColor.YELLOW);
        break;
    }
  }
}
