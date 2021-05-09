import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hatchery/api/API.dart';
import 'package:hatchery/common/log.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hatchery/common/widget/webview_common.dart';
import 'package:hatchery/config.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'dart:convert' as convert;
import 'package:hatchery/api/entity.dart';
import 'dart:collection';
import 'package:hatchery/common/tools.dart';
import 'package:hatchery/routers.dart';

class SplashManager extends ChangeNotifier {
  /// 是否显示 协议确认UI
  bool? showAgreement;

  Advertising? advertising;

  int? countDown;

  Timer? countDownTimer;

  Timer? timeOutTimer;

  /// 初始化
  init() {
    Log.log("SplashManager 初始化", color: LColor.YELLOW);
    SP.init().then((sp) async {
      bool spValue = SP.getBool(SPKey.showAgreement) ?? true;
      Log.log("showAgreement = $spValue", color: LColor.YELLOW);
      showAgreement = spValue;
      if (spValue) {
        //跳转 显示 Agreement
        Routers.navigateTo("/agreementPage");
      } else {
        //显示广告
        timeOutCountDownTime();
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
    Log.log("更新 配置", color: LColor.Magenta);
    API.getConfig().then((value) {
      if (value.isSuccess()) {
        SP.set(SPKey.CONFIG_KEY, json.encode(value.getData()));
      }
    });
  }

  ///更新 闪屏 广告
  _querySplashAd() async {
    Log.log("更新 闪屏 广告", color: LColor.YELLOW);
    API.getSplashADList(0, 1, Flavors.appId.serviceAd).then((value) {
      if (value.isSuccess()) {
        var news = value.getDataList((m) => Advertising.fromJson(m));
        if (news.isNotEmpty) {
          Log.log("存 闪屏 广告 = ${news[0].toJson()}", color: LColor.YELLOW);
          SP.set(SPKey.splashAD, jsonEncode(news[0].toJson()));
        } else {
          Log.log("闪屏无广告配置 = ${news}", color: LColor.YELLOW);
          SP.delete(SPKey.splashAD);
        }
      }
    });
  }

  ///更新 弹框 广告
  _queryPopAd() async {
    Log.log("更新 弹框 广告", color: LColor.YELLOW);
    API.getPopupADList(0, 1, Flavors.appId.serviceAd).then((value) {
      if (value.isSuccess()) {
        var news = value.getDataList((m) => Advertising.fromJson(m));
        if (news.isNotEmpty) {
          Log.log("存 弹框 广告 = ${news[0].toJson()}", color: LColor.YELLOW);
          SP.set(SPKey.popAD, jsonEncode(news[0].toJson()));
        } else {
          Log.log("弹框无广告配置 = ${news}", color: LColor.YELLOW);
          SP.delete(SPKey.popAD);
        }
      }
    });
  }

  _getStoredForSplashAd() async {
    String? stored = SP.getString(SPKey.splashAD);
    if (stored != null) {
      Log.log("stored stored =  $stored", color: LColor.YELLOW);
      try {
        var ad = Advertising.fromJson(jsonDecode(stored));
        advertising = ad;
        notifyListeners();
      } catch (e) {}
    } else {
      Log.log("没有广告", color: LColor.YELLOW);
      Future.delayed(Duration(seconds: 1), () => Routers.navigateReplace('/'));
    }
  }

  /// 开屏广告倒计时
  splashCountDownTime() {
    // 开始倒计时
    //显示 广告 和 倒计时
    countDown = TimeConfig.SPLASH_TIMEOUT;
    countDownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      Log.log("countDownTimer_timer $countDown", color: LColor.YELLOW);
      countDown = countDown! - 1;
      if (countDown! < 1) {
        stopAllTimer();
        timer.cancel();
        Routers.navigateReplace('/');
      }
      notifyListeners();
    });
  }

  /// 开屏总超时
  timeOutCountDownTime() {
    //显示 广告 和 倒计时
    int timeOutCountDown = TimeConfig.SPLASH_TIMEOUT + 3;
    if (timeOutTimer == null) {
      timeOutTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        timeOutCountDown--;
        Log.log("timeOutCountDownTime _timer $timeOutCountDown",
            color: LColor.YELLOW);
        if (timeOutCountDown == 0) {
          stopAllTimer();
          timer.cancel();
          Routers.navigateReplace('/');
        }
      });
    }
  }

  Future<Advertising?> getSplashAdSPValue() async {
    String? stored = SP.getString(SPKey.splashAD);
    if (stored != null) {
      return Advertising.fromJson(jsonDecode(stored));
    } else {
      return null;
    }
  }

  preloadSplashAdImage() {
    Future.delayed(
        Duration(seconds: 3),
        () => getSplashAdSPValue().then((value) {
              if (value != null) {
                Log.log("_preloadSplashAdImage = ${value.image}",
                    color: LColor.YELLOW);
                CachedNetworkImage(
                  imageUrl: value.image,
                  imageBuilder: (context, imageProvider) => Container(),
                );
              }
            }));
  }

  /// 停止所有计时器
  void stopAllTimer() {
    countDownTimer?.cancel();
    timeOutTimer?.cancel();
  }

  /// UI动作 点击广告
  void clickAD() {
    if (advertising != null) {
      stopAllTimer();
      Routers.navWebViewReplace(advertising!.redirectUrl);
    }
  }

  /// UI动作 跳过倒计时
  void skip() {
    Log.log("countDownTimer?.cancel() countDownTimer?.cancel()");
    stopAllTimer();
    Routers.navigateReplace('/');
  }

  /// 点击同意协议按钮
  void clickAgreeAgreementButton(BuildContext context) async {
    SP.set(SPKey.showAgreement, false); // 设置协议是否同意标识
    Routers.navigateReplace('/');
    _queryConfigData();
    _querySplashAd();
    // _queryPopAd();
  }

  /// 查看用户协议webview
  void gotoUserAgreementUrl() =>
      // Routers.navWebView(Flavors.stringsInfo.user_agreement_url, title: '用户协议');
      Routers.navigateTo('/pact');

  /// 查看隐私协议webview
  void gotoPrivacyAgreementUrl() => Routers.navigateTo('/privacy');
  // Routers.navWebView(Flavors.stringsInfo.privacy_agreement_url,
  //     title: '隐私协议');

  @override
  void dispose() {
    stopAllTimer();
    super.dispose();
  }
}
