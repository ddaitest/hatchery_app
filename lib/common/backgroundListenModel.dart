import 'package:flutter/material.dart';
import 'package:hatchery/common/log.dart';
import 'dart:async';
import 'package:hatchery/routers.dart';
import 'package:hatchery/config.dart';
import 'package:hatchery/business/main_tab.dart';

class BackLock {
  ///当特殊工作时候，进行标记。如选照片。
  static bool working = false;
}

class BackgroundListen with WidgetsBindingObserver {
  DateTime backGroundTime = DateTime.now();

  void init() {
    WidgetsBinding.instance?.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
  }

  /// 切后台时的时间减回到前台时的时间，大于等于指定时间则跳转至splash
  Future<bool> checkShowSplash(DateTime? beforeTime) async {
    Log.log("BackLock.working===> ${BackLock.working}", color: LColor.YELLOW);
    if (BackLock.working) {
      return false;
    }
    if (beforeTime != null) {
      DateTime frontTime = DateTime.now();
      Log.log("frontTime $frontTime", color: LColor.YELLOW);
      int? diffTime = frontTime.difference(beforeTime).inSeconds;
      int? waitTime = TimeConfig.BACKGROUND_SPLASH_WAIT_TIME;
      Log.log("diffTime $diffTime", color: LColor.YELLOW);
      if (diffTime >= waitTime) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        Log.log("inactive #################", color: LColor.YELLOW);
        break;
      case AppLifecycleState.resumed: // 应用程序可见，前台
        Log.log("resumed #################", color: LColor.YELLOW);
        checkShowSplash(backGroundTime).then((value) {
          if (value) Routers.navigateTo('/');
        });
        break;
      case AppLifecycleState.paused: // 应用程序不可见，后台
        Log.log("paused #################", color: LColor.YELLOW);
        backGroundTime = DateTime.now();
        break;
      case AppLifecycleState.detached:
        Log.log("detached #################", color: LColor.YELLOW);
        break;
    }
  }
}
