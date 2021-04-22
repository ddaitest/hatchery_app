import 'dart:collection';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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

  DateTime now = DateTime.now();

  int localSetPopShowTimes = 0;

  List<ServiceInfo> services = [
    //TODO fix
    // ServiceInfo('images/image8.png', "问题反馈", "feedback"),
    // ServiceInfo('images/image1.png', "房屋租售", "service3"),
    // ServiceInfo('images/image3.png', "开锁换锁", "service5"),
    // ServiceInfo('images/image5.png', "便民服务", "service1"),
    serviceinfo1,
    serviceinfo2,
    serviceinfo3,
    ServiceInfo('images/image5.png', "全部服务", "all_service")
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
        MainTabHandler.gotoTab(1);
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
      now = DateTime.now();
      localSetPopShowTimes = _getLocalPopShowTimes(now);
      int responsePopAdTimes =
          _getPopAdShowTimes() ?? TimeConfig.DEFAULT_SHOW_POP_TIMES;
      Log.log("checkPopAd.times = $localSetPopShowTimes $responsePopAdTimes",
          color: LColor.YELLOW);
      if (localSetPopShowTimes != responsePopAdTimes) {
        Advertising? popAd = _getStoredForPopAd();
        Log.log("checkPopAd.Advertising = $popAd", color: LColor.YELLOW);
        if (popAd != null) {
          _preloadPopAdImage(popAd);
          return popAd;
        }
      } else {
        return null;
      }
    });
  }

  _preloadPopAdImage(Advertising? value) {
    if (value != null) {
      Log.log("_preloadPopAdImage = ${value.image}", color: LColor.YELLOW);
      CachedNetworkImage(
        imageUrl: value.image,
        imageBuilder: (context, imageProvider) => Container(),
      );
    }
  }

  Advertising? _getStoredForPopAd() {
    String? stored = SP.getString(SPKey.popAD);
    Log.log("SP StoredForPopAd = $stored", color: LColor.YELLOW);
    if (stored != null) {
      try {
        return Advertising.fromJson(jsonDecode(stored));
      } catch (e) {}
    }
  }

  /// 获取SP中的当天弹出次数. 结构为String "2020_11_11@X",X为次数
  /// 用当天的日期如20210413作为key是判断SP中是否有对应的key，如果有则获取value的值
  /// 用value中的值去和服务器返回的做比较，相同则不弹，不相同则弹
  int _getLocalPopShowTimes(DateTime now) {
    try {
      var key = "${now.year}_${now.month}_${now.day}";
      String record = SP.getString(SPKey.popTimes) ?? "";
      Log.log("SP GET.record = $record", color: LColor.YELLOW);
      if (record.contains(key)) {
        String times = record.substring(key.length + 1);
        Log.log("SP LC = ${times}", color: LColor.YELLOW);
        return int.parse(times);
      }
    } catch (e) {}
    return 0;
  }

  /// 记录pop ad 弹出次数，结构为String "2020_11_11@X",X为次数
  setPopShowCount(DateTime now, int times) {
    var key = "${now.year}_${now.month}_${now.day}";
    SP.set(SPKey.popTimes, "$key@$times");
    Log.log("SP SAVE.record = $key@$times", color: LColor.YELLOW);
  }

  /// 获取config中的pop广告弹出次数，如果获取不到则用default.dart中默认的值
  int? _getPopAdShowTimes() {
    String? _responseResult = SP.getString(SPKey.CONFIG_KEY);
    if (_responseResult != null) {
      Map<String, dynamic>? _finalParse = jsonDecode(_responseResult);
      int? popAdShowTotalTimesForResponse =
          _finalParse?['popup_ad']?['show_times'] ?? null;
      Log.log(
          "popAdShowTotalTimesForResponse = $popAdShowTotalTimesForResponse",
          color: LColor.RED);
      if (popAdShowTotalTimesForResponse == null) {
        return TimeConfig.DEFAULT_SHOW_POP_TIMES;
      } else {
        return popAdShowTotalTimesForResponse;
      }
    }
  }

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
