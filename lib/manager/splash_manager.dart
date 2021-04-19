import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hatchery/api/API.dart';
import 'package:hatchery/common/log.dart';
import 'package:hatchery/common/widget/webview_common.dart';
import 'package:hatchery/config.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'dart:convert' as convert;
import 'package:flutter/services.dart';
import 'package:hatchery/api/entity.dart';
import 'dart:collection';
import 'package:hatchery/common/tools.dart';
import 'package:hatchery/routers.dart';

class SplashManager extends ChangeNotifier {
  /// 是否显示 协议确认UI
  bool? showAgreement;

  Advertising? advertising;

  int? countDown;

  Timer? _timer;

  /// 初始化
  init() {
    Log.log("SplashManager 初始化", color: LColor.YELLOW);
    SP.init().then((sp) {
      bool spValue = SP.getBool(SPKey.showAgreement) ?? true;
      Log.log("showAgreement = $spValue", color: LColor.YELLOW);
      showAgreement = spValue;
      if (spValue) {
        //跳转 显示 Agreement
        Routers.navigateTo("/agreementPage");
      } else {
        //显示广告
        _getStoredForSplashAd();
        //更新数据
        _queryConfigData();
        _querySplashAd();
        _queryPopAd();
      }
    });
  }

  ///更新 配置
  _queryConfigData() async {
    Log.log("更新 闪屏 广告", color: LColor.Magenta);
    API.getConfig().then((value) {
      if (value.isSuccess()) {
        SP.set(SPKey.CONFIG_KEY, json.encode(value.getData()));
      }
    });
  }

  ///更新 闪屏 广告
  _querySplashAd() async {
    Log.log("更新 闪屏 广告", color: LColor.YELLOW);
    API.getSplashADList(0, 1, Flavors.appId.splash_page_id).then((value) {
      if (value.isSuccess()) {
        var news = value.getDataList((m) => Advertising.fromJson(m));
        if (news.isNotEmpty) {
          Log.log("存 闪屏 广告 = ${news[0].toJson()}", color: LColor.YELLOW);
          SP.set(SPKey.splashAD, jsonEncode(news[0].toJson()));
        }
      }
    });
  }

  ///更新 弹框 广告
  _queryPopAd() async {
    Log.log("更新 弹框 广告", color: LColor.YELLOW);
    API.getPopupADList(0, 1, "tab1").then((value) {
      if (value.isSuccess()) {
        var news = value.getDataList((m) => Advertising.fromJson(m));
        if (news.isNotEmpty) {
          Log.log("存 弹框 广告 = ${news[0].toJson()}", color: LColor.YELLOW);
          SP.set(SPKey.popAD, jsonEncode(news[0].toJson()));
        }
      }
    });
  }

  _getStoredForSplashAd() {
    String? stored = SP.getString(SPKey.splashAD);
    if (stored != null) {
      try {
        var ad = Advertising.fromJson(jsonDecode(stored));
        //显示 广告 和 倒计时
        countDown = TimeConfig.SPLASH_TIMEOUT;
        advertising = ad;
        notifyListeners();
        // 开始倒计时
        _timer = Timer.periodic(Duration(seconds: 1), (timer) {
          var t = countDown! - 1;
          Log.log("Timer $t", color: LColor.YELLOW);
          if (t == 0) {
            _timer?.cancel();
            Routers.navigateReplace('/');
            return;
          }
          countDown = t;
          notifyListeners();
        });
      } catch (e) {}
    } else {
      Log.log("没有广告", color: LColor.YELLOW);
      Timer.periodic(Duration(seconds: 1), (timer) {
        _timer?.cancel();
        Routers.navigateReplace('/');
      });
    }
  }

  /// UI动作 点击广告
  void clickAD() {
    if (advertising != null) {
      _timer?.cancel();
      Routers.navWebViewReplace(advertising!.redirectUrl);
    }
  }

  /// UI动作 跳过倒计时
  void skip() {
    _timer?.cancel();
    Routers.navigateReplace('/');
  }

  /// 点击同意协议按钮
  void clickAgreeAgreementButton(BuildContext context) async {
    SP.set(SPKey.showAgreement, false); // 设置协议是否同意标识
    Routers.navigateReplace('/');
  }

  /// 查看用户协议webview
  void gotoUserAgreementUrl() =>
      Routers.navWebView(Flavors.stringsInfo.user_agreement_url, title: '用户协议');

  /// 查看隐私协议webview
  void gotoPrivacyAgreementUrl() =>
      Routers.navWebView(Flavors.stringsInfo.privacy_agreement_url,
          title: '隐私协议');

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
