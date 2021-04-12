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
import 'package:hatchery/manager/service_manager.dart';

class HomeManager extends ChangeNotifier {
  //当前页面状态
  PageStatus _status = PageStatus.LOADING;

  //banner 数据
  List<BannerInfo> _bannerList = [];

  //公告内容
  List<Notice> _noticesList = [];

  //软文
  List<Article> _articlesList = [];

  //弹窗广告
  List<Advertising> _popAdList = [];

  PageStatus get status => _status;

  UnmodifiableListView<BannerInfo> get bannerList =>
      UnmodifiableListView(_bannerList);

  UnmodifiableListView<Notice> get noticesList =>
      UnmodifiableListView(_noticesList);

  UnmodifiableListView<Article> get articlesList =>
      UnmodifiableListView(_articlesList);

  UnmodifiableListView<Advertising> get popAdList =>
      UnmodifiableListView(_popAdList);

  HomeManager() {
    _queryNoticesData();
    _queryBannerData();
    queryArticleData();
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
            _bannerList = [];
          }
        } else {
          _bannerList = [];
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
            _noticesList = [];
          }
        } else {
          _noticesList = [];
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
            _articlesList = [];
          }
        } else {
          _articlesList = [];
        }
      }
    });
    notifyListeners();
  }

  _queryPopAdData() async {
    await API.getPopupADList(0, 10, Flavors.appId.home_page_id).then((value) {
      if (value.isSuccess()) {
        List<dynamic>? _finalParse = value.getData();
        if (_finalParse != null) {
          if (_finalParse.isNotEmpty) {
            _finalParse.forEach((element) {
              addPopAd(Advertising.fromJson(element));
            });
          } else {
            _popAdList = [];
          }
        } else {
          _popAdList = [];
        }
      }
    });
    notifyListeners();
  }

  void addArticles(Article item) {
    _articlesList.add(item);
  }

  void addNotices(Notice item) {
    _noticesList.add(item);
  }

  void addBanner(BannerInfo item) {
    _bannerList.add(item);
  }

  void addPopAd(Advertising item) {
    _popAdList.add(item);
  }

  void clickBanner(int index) {}

  void clickPopAd(Advertising value) => Routers.navWebView(value.redirectUrl);

  @override
  void dispose() {
    super.dispose();
  }
}
