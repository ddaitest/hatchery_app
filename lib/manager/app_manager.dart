import 'package:flutter/material.dart';

class AppManager extends ChangeNotifier {
  int _m = 0;

  int get m => _m;

  void apptest() {
    _m++;
    notifyListeners();
  }

  static final AppManager _instance = AppManager._create();

  factory AppManager() => _instance;

  AppManager._create() {
    print("MainManager init $hashCode");
  }
}
