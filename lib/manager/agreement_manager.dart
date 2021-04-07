import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/business/main_tab.dart';
import 'package:hatchery/business/splash/splash.dart';
import 'package:hatchery/common/route_animation.dart';
import 'package:hatchery/business/home/home.dart';
import 'package:hatchery/common/widget/webview_common.dart';
import 'package:hatchery/configs.dart';
import 'package:dio/dio.dart';
import 'package:hatchery/common/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:hatchery/manager/beans.dart';
import 'dart:collection';
import 'package:hatchery/common/tools.dart';

class AgreementManager extends ChangeNotifier {
  final String KEY_AGREEMENT = 'agreedAgreement';
  /// 是否显示 协议确认UI
  bool _agreedAgreement = true;

  bool get agreedAgreement => _agreedAgreement;

  AgreementManager(BuildContext context) {
    _getLocalData(context);
  }

  /// 获取协议是否同意标识
  _getLocalData(context) {
    // sharedGetData('agreedAgreement').then((sp) {
    //   _agreedAgreement = sp ?? false;
    //   if (_agreedAgreement) {
    //     Navigator.pushReplacement(context, AnimationRoute(SplashPage(), 3));
    //   }
    // });
    _agreedAgreement = SP.getBool(KEY_AGREEMENT)??false;
    if (_agreedAgreement) {
      Navigator.pushReplacement(context, AnimationRoute(SplashPage(), 3));
    }
  }

  /// 点击同意协议按钮
  void clickAgreeAgreementButton(BuildContext context) {
    // sharedAddAndUpdate('agreedAgreement', bool, true); // 设置协议是否同意标识
    SP.set(KEY_AGREEMENT, true);
    Navigator.pushReplacementNamed(context, '/');
  }

  /// 查看协议webview
  void gotoAgreementUrl(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WebViewPage(AGREEMENT, null)),
    );
  }

  Future<void> exitApp() async {
    if (Platform.isAndroid) {
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } else if (Platform.isIOS) {
      exit(0);
    } else {
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      exit(0);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
