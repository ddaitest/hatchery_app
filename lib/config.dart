import 'package:flutter/material.dart';

import 'api/entity.dart';

const bool TEST = true;

class SPKey {
  static final String showAgreement = 'ShowAgreement';
  static final String splashAD = 'splashAD';
  static final String popAD = 'popAD';
  static final String popTimes = 'popTimes';
  static final String CONFIG_KEY = 'configKey';
  static final String upgrade = 'upgrade';

  // static final String POP_AD_SHOW_TIMES_KEY = 'popShowTimesKey';
  static final String COMMON_PARAM_KEY = 'commonParamKey';
  static final String USER_ID_KEY = 'USER_ID_KEY';
}

class TimeConfig {
  static final int SPLASH_TIMEOUT = TEST ? 3 : 5;
  static final int POP_AD_WAIT_TIME = TEST ? 1 : 5;
  static final int UPGRADE_SHOW_DELAY = TEST ? 5 : 10;
  static final int UPGRADE_WAIT_DAY = TEST ? 3 : 3;
  static final int DEFAULT_SHOW_POP_TIMES = TEST ? 5 : 1;
  static final int BACKGROUND_SPLASH_WAIT_TIME = TEST ? 3 : 60;
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

const serviceinfo1 = ServiceInfo('images/image8.png', "问题反馈", "feedback");
const serviceinfo2 = ServiceInfo('images/image7.png', "报事报修", "repairs");
const serviceinfo3 = ServiceInfo('images/image6.png', "联系物业", "contact");
const serviceinfo4 = ServiceInfo('images/image5.png', "便民服务", "service1");
const serviceinfo5 = ServiceInfo('images/image4.png', "家电维修", "service2");
const serviceinfo6 = ServiceInfo('images/image1.png', "房屋租售", "service3");
const serviceinfo7 = ServiceInfo('images/image2.png', "教育培训", "service4");
const serviceinfo8 = ServiceInfo('images/image3.png', "开锁换锁", "service5");
