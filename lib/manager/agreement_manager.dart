import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/manager/app_manager.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:hatchery/routers.dart';
import 'package:flutter/services.dart';
import 'package:hatchery/common/tools.dart';

class AgreementManager extends ChangeNotifier {
  /// 是否显示 协议确认UI
  bool _agreedAgreement = true;

  bool get agreedAgreement => _agreedAgreement;

  AgreementManager() {}

  /// 点击同意协议按钮
  void clickAgreeAgreementButton(BuildContext context) async {
    await SP.set(
        Flavors.localSharedPreferences.Agreement_DATA_KEY, true); // 设置协议是否同意标识
    await AppManager().querySplashAdData();
    Routers.navigateReplace('/');
  }

  /// 查看用户协议webview
  void gotoUserAgreementUrl() =>
      Routers.navWebView(Flavors.stringsInfo.user_agreement_url);

  /// 查看隐私协议webview
  void gotoPrivacyAgreementUrl() =>
      Routers.navWebView(Flavors.stringsInfo.privacy_agreement_url);

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
