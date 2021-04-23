import 'package:flutter/material.dart';
import 'package:hatchery/common/log.dart';

class BackgroundListen with WidgetsBindingObserver {
  void init() {
    WidgetsBinding.instance?.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
  }

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
