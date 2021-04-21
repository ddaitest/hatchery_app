import 'package:flutter/material.dart';

import 'api/entity.dart';

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
//     { key: 0, value: "tab1", label: "首页" },
//     { key: 1, value: "tab2", label: "服务" },
//     { key: 2, value: "tab3", label: "周边" },
//     { key: 3, value: "service1", label: "便民服务" },
//     { key: 4, value: "service2", label: "家电维修" },
//     { key: 4, value: "service3", label: "房屋租售" },
//     { key: 4, value: "service4", label: "教育培训" },
//     { key: 4, value: "service5", label: "开锁换锁" },

const serviceinfo1 = ServiceInfo('images/image8.png', "问题反馈", "feedback");
const serviceinfo2 = ServiceInfo('images/image7.png', "报事报修", "repairs");
const serviceinfo3 = ServiceInfo('images/image6.png', "联系物业", "contact");
// const serviceinfo4 = ServiceInfo('images/image5.png', "便民服务", "service1");
const serviceinfo4 = ServiceInfo('images/image5.png', "便民服务", "tab1");
const serviceinfo5 = ServiceInfo('images/image4.png', "家电维修", "service2");
const serviceinfo6 = ServiceInfo('images/image1.png', "房屋租售", "service3");
const serviceinfo7 = ServiceInfo('images/image2.png', "教育培训", "service4");
const serviceinfo8 = ServiceInfo('images/image3.png', "开锁换锁", "service5");
