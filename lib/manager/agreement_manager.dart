import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hatchery/common/widget/webview_common.dart';
import 'package:hatchery/configs.dart';
import 'package:hatchery/business/home/home.dart';
import 'package:dio/dio.dart';
import 'package:hatchery/common/api.dart';
import 'package:flutter/services.dart';
import 'package:hatchery/manager/beans.dart';
import 'dart:collection';
import 'package:hatchery/common/route_animation.dart';
import 'package:hatchery/common/tools.dart';

class AgreementManager extends ChangeNotifier {
  AgreementManager(BuildContext context) {}

  /// 点击"同意协议"按钮
  void agree(BuildContext context) {
    sharedAddAndUpdate(Agreement_DATA_KEY, bool, true); // 设置协议是否同意标识
    Navigator.of(context).pushReplacement(
        CupertinoPageRoute(builder: (BuildContext context) => HomePage()));
  }

  /// 点击协议webview
  void agreementUrl(BuildContext context) {
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
