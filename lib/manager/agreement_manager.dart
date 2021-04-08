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
import 'package:flutter/services.dart';
import 'dart:collection';
import 'package:hatchery/common/tools.dart';

class AgreementManager extends ChangeNotifier {
  /// 是否显示 协议确认UI
  bool _agreedAgreement = true;

  bool get agreedAgreement => _agreedAgreement;

  AgreementManager() {}

  /// 点击同意协议按钮
  void clickAgreeAgreementButton(BuildContext context) {
    SP.set(Agreement_DATA_KEY, true); // 设置协议是否同意标识
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
