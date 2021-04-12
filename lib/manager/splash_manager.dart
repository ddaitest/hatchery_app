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
import 'package:hatchery/configs.dart';

class SplashManager extends ChangeNotifier {
  List<Advertising> _splashAdLists = [];

  UnmodifiableListView<Advertising> get splashAdLists =>
      UnmodifiableListView(_splashAdLists);

  SplashManager(BuildContext context) {
    _getSplashAdData(context);
  }

  List<String>? _getSplashAdData(context) {
    String? _responseResult =
        SP.getString(Flavors.localSharedPreferences.SPLASH_AD_RESPONSE_KEY);
    if (_responseResult != null) {
      List<dynamic>? _finalParse = jsonDecode(_responseResult);
      print("DEBUG=> _finalParse ${_finalParse}");
      _finalParse!.forEach((element) {
        addSplashAdData(Advertising.fromJson(element));
      });
      if (_splashAdLists.isEmpty) {
        routeHomePage(context);
      }
    } else {
      _splashAdLists = [];
      routeHomePage(context);
    }
  }

  void addSplashAdData(Advertising item) {
    _splashAdLists.add(item);
  }

  /// UI动作 点击广告
  void clickAD(BuildContext context) {
    if (_splashAdLists.isNotEmpty)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                WebViewPage(_splashAdLists[0].redirectUrl, '/')),
      );
  }

  /// UI动作 跳过倒计时
  void skip(BuildContext context) {
    routeHomePage(context);
  }

  void routeHomePage(context) {
    Future.delayed(Duration.zero, () async {
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
