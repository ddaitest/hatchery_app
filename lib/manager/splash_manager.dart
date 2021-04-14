import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hatchery/common/widget/webview_common.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'dart:convert' as convert;
import 'package:flutter/services.dart';
import 'package:hatchery/api/entity.dart';
import 'dart:collection';
import 'package:hatchery/common/tools.dart';
import 'package:hatchery/routers.dart';

class SplashManager extends ChangeNotifier {
  List<Advertising> _splashAdLists = [];

  UnmodifiableListView<Advertising> get splashAdLists =>
      UnmodifiableListView(_splashAdLists);

  Timer? _timer;

  Timer get timer => _timer!;

  SplashManager() {
    _getSplashAdData();
    _timer = Timer.periodic(
        Duration(seconds: Flavors.timeConfig.SPLASH_TIMEOUT), (timer) {
      routeHomePage();
    });
  }

  List<String>? _getSplashAdData() {
    String? _responseResult =
        SP.getString(Flavors.localSharedPreferences.SPLASH_AD_RESPONSE_KEY);
    if (_responseResult != null) {
      List<dynamic>? _finalParse = jsonDecode(_responseResult);
      print("DEBUG=> _finalParse ${_finalParse}");
      _finalParse!.forEach((element) {
        addSplashAdData(Advertising.fromJson(element));
      });
      if (_splashAdLists.isEmpty) {
        routeHomePage();
      }
    } else {
      _splashAdLists = [];
      routeHomePage();
    }
  }

  void addSplashAdData(Advertising item) {
    _splashAdLists.add(item);
  }

  /// UI动作 点击广告
  void clickAD() {
    if (_splashAdLists.isNotEmpty)
      Routers.navWebViewReplace(_splashAdLists[0].redirectUrl);
  }

  /// UI动作 跳过倒计时
  void skip(BuildContext context) {
    routeHomePage();
  }

  void routeHomePage() {
    Future.delayed(Duration.zero, () async {
      Routers.navigateReplace('/');
      _timer?.cancel();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
