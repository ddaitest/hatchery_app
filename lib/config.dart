import 'package:flutter/material.dart';

const bool TEST = true;

class SPKey {
  static final String showAgreement = 'ShowAgreement';
  static final String splashAD = 'splashAD';
  static final String popAD = 'popAD';
  static final String popTimes = 'popTimes';
  static final String CONFIG_KEY = 'configKey';

  // static final String POP_AD_SHOW_TIMES_KEY = 'popShowTimesKey';
  static final String COMMON_PARAM_KEY = 'commonParamKey';
}

class TimeConfig {
  static final int SPLASH_TIMEOUT = TEST ? 3 : 5;
  static final int POP_AD_WAIT_TIME = TEST ? 3 : 3;
  static final int UPGRADE_LOADING_TIME = TEST ? 1 : 5;
  static final int DEFAULT_SHOW_POP_TIMES = TEST ? 1 : 1;
}

const mainTabs = [
  TabInfo('首页', Icons.home_outlined, Icons.home),
  TabInfo('服务', Icons.home_repair_service_outlined, Icons.home_repair_service),
  TabInfo('周边', Icons.near_me_outlined, Icons.near_me),
];

class TabInfo {
  final String label;
  final IconData icon;
  final IconData activeIcon;

  const TabInfo(this.label, this.icon, this.activeIcon);
}
