import 'package:get_it/get_it.dart';

import 'manager/main_manager.dart';
import 'test/a_model.dart';
import 'test/test_model.dart';

const bool TEST = true;

const int SPLASH_TIME = TEST ? 1 : 3;
const int SMS_RESEND = TEST ? 5 : 30;
const String AMAP_KEY = "30a97518348a9b6b8cc652b2dbabe3a2";

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerFactory<TestModel>(() => TestModel());
  locator.registerFactory<AppManager>(() => AppManager());
}
