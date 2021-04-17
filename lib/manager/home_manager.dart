import 'dart:collection';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/common/AppContext.dart';
import 'package:hatchery/common/PageStatus.dart';
import 'package:hatchery/api/API.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:hatchery/routers.dart';
import 'package:hatchery/common/tools.dart';
import 'package:hatchery/manager/service_manager.dart';
import 'package:date_format/date_format.dart';
import 'package:hatchery/api/ApiResult.dart';

class HomeManager extends ChangeNotifier {
  //当前页面状态
  PageStatus _status = PageStatus.LOADING;

  //banner 数据
  List<BannerInfo> bannerList = [];

  //公告内容
  List<Notice> noticesList = [];

  //软文
  List<Article> articlesList = [];

  //弹窗广告
  List<Advertising> popAdList = [];

  /// 服务器返回弹窗广告次数
  int? _popAdShowTotalTimesForResponse;

  /// 本地存储的弹窗已经弹过的广告次数
  int? _popAdShowTotalTimesForLocal;

  int currentTab = 0;

  DateTime now = DateTime.now();

  PageStatus get status => _status;

  late PageController pageController =
      PageController(initialPage: this.currentTab);

  HomeManager() {
    _getLocalPopShowTimes();
    _queryNoticesData();
    _queryBannerData();
    queryArticleData();
    _getPopAdShowTimes();
    _queryPopAdData();
  }

  List<ServiceInfo> services = [
    //TODO fix
    ServiceInfo('images/image1.png', "问题反馈", "feedback"),
    ServiceInfo('images/image2.png', "报事报修", "repairs"),
    ServiceInfo('images/image3.png', "联系物业", "contact"),
    ServiceInfo('images/image4.png', "全部服务", "all_service"),
  ];

  clickService(ServiceInfo serviceInfo) {
    switch (serviceInfo.serviceId) {
      case "all_service":
        //TODO TAB 服务业
        break;
      default:
        // 使用统一逻辑处理。
        App.manager<ServiceManager>().clickService(serviceInfo);
        break;
    }
  }

  /// 获取SP中的当天弹出次数结构为map = {'today': 1}
  /// 用当天的日期如20210413作为key是判断SP中是否有对应的key，如果有则获取value的值
  /// 用value中的值去和服务器返回的做比较，相同则不弹，不相同则弹
  _getLocalPopShowTimes() {
    String _nowDay =
        formatDate(DateTime(now.year, now.month, now.day), [yyyy, mm, dd]);
    String? _responseResult =
        SP.getString(Flavors.localSharedPreferences.POP_AD_SHOW_TIMES_KEY);
    if (_responseResult != null) {
      Map<String, dynamic>? _finalParse = jsonDecode(_responseResult);
      if (_finalParse!.containsKey(_nowDay)) {
        _popAdShowTotalTimesForLocal = _finalParse[_nowDay];
      } else {
        SP.delete(Flavors.localSharedPreferences.POP_AD_SHOW_TIMES_KEY);
        _popAdShowTotalTimesForLocal = 0;
      }
    } else {
      _popAdShowTotalTimesForLocal = 0;
    }
  }

  _queryBannerData() async {
    await API.getBannerList(0, 10, Flavors.appId.home_page_id).then((value) {
      if (value.isSuccess()) {
        List<dynamic>? _finalParse = value.getData();
        if (_finalParse != null) {
          if (_finalParse.isNotEmpty) {
            _finalParse.forEach((element) {
              addBanner(BannerInfo.fromJson(element));
            });
          } else {
            bannerList = [];
          }
        } else {
          bannerList = [];
        }
      }
    });
    notifyListeners();
  }

  _queryNoticesData() async {
    await API.getNoticeList(0, 10, Flavors.appId.home_page_id).then((value) {
      if (value.isSuccess()) {
        List<dynamic>? _finalParse = value.getData();
        if (_finalParse != null) {
          if (_finalParse.isNotEmpty) {
            _finalParse.forEach((element) {
              addNotices(Notice.fromJson(element));
            });
          } else {
            noticesList = [];
          }
        } else {
          noticesList = [];
        }
      }
    });
    notifyListeners();
  }

  queryArticleData() async {
    await API.getArticleList(0, 10, Flavors.appId.home_page_id).then((value) {
      if (value.isSuccess()) {
        List<dynamic>? _finalParse = value.getData();
        if (_finalParse != null) {
          if (_finalParse.isNotEmpty) {
            _finalParse.forEach((element) {
              addArticles(Article.fromJson(element));
            });
          } else {
            articlesList = [];
          }
        } else {
          articlesList = [];
        }
      }
    });
    notifyListeners();
  }

  _queryPopAdData() async {
    if (_popAdShowTotalTimesForLocal != _popAdShowTotalTimesForResponse)
      await API.getPopupADList(0, 10, Flavors.appId.home_page_id).then((value) {
        if (value.isSuccess()) {
          List<dynamic>? _finalParse = value.getData();
          if (_finalParse != null) {
            if (_finalParse.isNotEmpty) {
              _finalParse.forEach((element) {
                addPopAd(Advertising.fromJson(element));
              });
            } else {
              popAdList = [];
            }
          } else {
            popAdList = [];
          }
        }
      });
    notifyListeners();
  }

  /// 记录pop ad 弹出次数，日期作为key，次数作为value
  setPopShowCount() {
    Map<String, int> _popAdShowMap = {
      '${formatDate(DateTime(now.year, now.month, now.day), [yyyy, mm, dd])}':
          _popAdShowTotalTimesForLocal! + 1
    };
    SP.set(Flavors.localSharedPreferences.POP_AD_SHOW_TIMES_KEY,
        json.encode(_popAdShowMap));
  }

  /// 获取config中的pop广告弹出次数，如果获取不到则用default.dart中默认的值
  _getPopAdShowTimes() {
    String? _responseResult =
        SP.getString(Flavors.localSharedPreferences.CONFIG_KEY);
    if (_responseResult != null) {
      Map<String, dynamic>? _finalParse = jsonDecode(_responseResult);
      _popAdShowTotalTimesForResponse = _finalParse?['popup_ad']['show_times'];
      if (_popAdShowTotalTimesForResponse == null) {
        _popAdShowTotalTimesForResponse =
            Flavors.timeConfig.DEFAULT_SHOW_POP_TIMES;
      }
      print(
          "DEBUG=> _popAdShowTotalTimesForResponse ${_popAdShowTotalTimesForResponse}");
      print(
          "DEBUG=> _popAdShowTotalTimesForLocal ${_popAdShowTotalTimesForLocal}");
    }
  }

  void addArticles(Article item) {
    articlesList.add(item);
  }

  void addNotices(Notice item) {
    noticesList.add(item);
  }

  void addBanner(BannerInfo item) {
    bannerList.add(item);
  }

  void addPopAd(Advertising item) {
    popAdList.add(item);
  }

  _clearDataList() {
    bannerList.clear();
    noticesList.clear();
    articlesList.clear();
  }

  /// 页面首次加载 or 刷新
  Future<PageRefreshStatus> refresh() async {
    _clearDataList();
    notifyListeners();
    Future.delayed(Duration(milliseconds: 500), () async {
      _queryNoticesData();
      _queryBannerData();
      queryArticleData();
      notifyListeners();
    });

    return PageRefreshStatus.completed;
  }

  void clickPopAd(Advertising value) => Routers.navWebView(value.redirectUrl);

  @override
  void dispose() {
    super.dispose();
  }

  void test(int a) {
    currentTab = a;
    notifyListeners();
  }
}
