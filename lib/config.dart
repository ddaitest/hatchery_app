const bool TEST = true;

const int POP_AD_LIMIT = 2;

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
  static final int SPLASH_TIMEOUT = TEST ? 6 : 6;
  static final int SPLASH_TIME = TEST ? 1 : 4;
  static final int POP_AD_WAIT_TIME = TEST ? 1 : 3;
  static final int UPGRADE_LOADING_TIME = TEST ? 1 : 5;
  static final int DEFAULT_SHOW_POP_TIMES = TEST ? 30 : 1;
}
