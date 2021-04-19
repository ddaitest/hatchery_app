import 'dart:collection';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/business/main_tab.dart';
import 'package:hatchery/common/AppContext.dart';
import 'package:hatchery/common/PageStatus.dart';
import 'package:hatchery/api/API.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/common/log.dart';
import 'package:hatchery/config.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:hatchery/routers.dart';
import 'package:hatchery/common/tools.dart';
import 'package:hatchery/manager/service_manager.dart';
import 'package:date_format/date_format.dart';
import 'package:hatchery/api/ApiResult.dart';

class HomeManager extends ChangeNotifier {
  // //当前页面状态
  // PageStatus _status = PageStatus.LOADING;

  //banner 数据
  List<BannerInfo> bannerList = [];

  //公告内容
  List<Notice> noticesList = [];

  //软文
  List<Article> articlesList = [];

  //弹窗广告
  // Advertising? popAd;

  // /// 服务器返回弹窗广告次数
  // int? _popAdShowTotalTimesForResponse;

  // /// 本地存储的弹窗已经弹过的广告次数
  // int? _popAdShowTotalTimesForLocal;

  // DateTime now = DateTime.now();

  // PageStatus get status => _status;

  List<ServiceInfo> services = [
    //TODO fix
    ServiceInfo('images/image1.png', "问题反馈", "feedback"),
    ServiceInfo('images/image2.png', "报事报修", "repairs"),
    ServiceInfo('images/image3.png', "联系物业", "contact"),
    ServiceInfo('images/image4.png', "全部服务", "all_service"),
  ];

  /// 页面首次加载 or 刷新
  Future<PageRefreshStatus> refresh() async {
    _queryBannerData();
    _queryArticleData();
    return _queryNoticesData();
  }

  clickService(ServiceInfo serviceInfo, BuildContext context) {
    switch (serviceInfo.serviceId) {
      case "all_service":
        MainTabHandler.of(context).gotoTab(1);
        break;
      default:
        App.manager<ServiceManager>().clickService(serviceInfo);
        break;
    }
  }

  ///监测是否显示POP广告.
  Future<Advertising?> checkPopAd() async {
    return Future.delayed(Duration(seconds: TimeConfig.POP_AD_WAIT_TIME), () {
      //判断是否应该显示
      var now = DateTime.now();
      int times = _getLocalPopShowTimes(now);
      Log.log("checkPopAd.times = $times",color: LColor.YELLOW);
      if (times <= POP_AD_LIMIT) {
        Advertising? ad = _getStoredAd();
        Log.log("checkPopAd.Advertising = $ad",color: LColor.YELLOW);
        if (ad != null) {
          setPopShowCount(now, times + 1);
          return ad;
        }
      }
    });
  }

  Advertising? _getStoredAd() {
    String? stored = SP.getString(SPKey.popAD);
    Log.log("SP StoredAd = $stored",color: LColor.YELLOW);
    if (stored != null) {
      try {
        return Advertising.fromJson(jsonDecode(stored));
      } catch (e) {}
    }
    return null;
  }

  /// 获取SP中的当天弹出次数. 结构为String "2020_11_11@X",X为次数
  /// 用当天的日期如20210413作为key是判断SP中是否有对应的key，如果有则获取value的值
  /// 用value中的值去和服务器返回的做比较，相同则不弹，不相同则弹
  int _getLocalPopShowTimes(DateTime now) {
    try {
      var key = "${now.year}_${now.month}_${now.day}";
      String record = SP.getString(SPKey.popTimes) ?? "";
      Log.log("SP GET.record = $record",color: LColor.YELLOW);
      if (record.contains(key)) {
        String times = record.substring(key.length + 1);
        return int.parse(times);
      }
    } catch (e) {}
    return 0;
  }

  /// 记录pop ad 弹出次数，结构为String "2020_11_11@X",X为次数
  setPopShowCount(DateTime now, int times) {
    var key = "${now.year}_${now.month}_${now.day}";
    SP.set(SPKey.popTimes, "$key@$times");
    Log.log("SP SAVE.record = $key@$times",color: LColor.YELLOW);
    // Map<String, int> _popAdShowMap = {
    //   '${formatDate(DateTime(now.year, now.month, now.day), [yyyy, mm, dd])}':
    //   _popAdShowTotalTimesForLocal! + 1
    // };
    // SP.set(SPKey.POP_AD_SHOW_TIMES_KEY, json.encode(_popAdShowMap));
  }

  //
  // /// 获取config中的pop广告弹出次数，如果获取不到则用default.dart中默认的值
  // _getPopAdShowTimes() {
  //   String? _responseResult = SP.getString(SPKey.CONFIG_KEY);
  //   if (_responseResult != null) {
  //     Map<String, dynamic>? _finalParse = jsonDecode(_responseResult);
  //     _popAdShowTotalTimesForResponse = _finalParse?['popup_ad']['show_times'];
  //     if (_popAdShowTotalTimesForResponse == null) {
  //       _popAdShowTotalTimesForResponse = TimeConfig.DEFAULT_SHOW_POP_TIMES;
  //     }
  //     print(
  //         "DEBUG=> _popAdShowTotalTimesForResponse ${_popAdShowTotalTimesForResponse}");
  //     print(
  //         "DEBUG=> _popAdShowTotalTimesForLocal ${_popAdShowTotalTimesForLocal}");
  //   }
  // }

  _queryBannerData() {
    API.getBannerList(0, 10, Flavors.appId.home_page_id).then((value) {
      if (value.isSuccess()) {
        var news = value.getDataList((m) => BannerInfo.fromJson(m));
        bannerList = news;
        notifyListeners();
      }
    });
  }

  Future<PageRefreshStatus> _queryNoticesData() async {
    var callback = PageRefreshStatus.completed;
    ApiResult result =
        await API.getNoticeList(0, 10, Flavors.appId.home_page_id);
    if (result.isSuccess()) {
      var news = result.getDataList((m) => Notice.fromJson(m));
      noticesList = news;
      notifyListeners();
    } else {
      callback = PageRefreshStatus.failed;
    }
    return callback;
  }

  _queryArticleData() {
    API.getArticleList(0, 10, Flavors.appId.home_page_id).then((value) {
      if (value.isSuccess()) {
        var news = value.getDataList((m) => Article.fromJson(m));
        articlesList = news;
        notifyListeners();
      }
    });
  }

  void clickPopAd(Advertising value) => Routers.navWebView(value.redirectUrl);

  @override
  void dispose() {
    super.dispose();
  }
}
