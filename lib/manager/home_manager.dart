import 'dart:collection';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/common/PageStatus.dart';
import 'package:hatchery/api/API.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/configs.dart';
import 'package:hatchery/common/tools.dart';
import 'package:hatchery/common/utils.dart';
import 'package:hatchery/common/exts.dart';

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
    Future.delayed(Duration(seconds: 3), () async {
      _queryPopAdData();
    });
  }

  _queryBannerData() async {
    await API.getBannerList(0, 10, HOME_ID).then((value) {
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
    await API.getNoticeList(0, 10, HOME_ID).then((value) {
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
    await API.getArticleList(0, 10, HOME_ID).then((value) {
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
    await API.getPopupADList(0, 10, HOME_ID).then((value) {
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

  @override
  void dispose() {
    super.dispose();
  }
}
