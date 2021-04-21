import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:hatchery/api/API.dart';
import 'package:hatchery/api/ApiResult.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/common/PageStatus.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/config.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'dart:collection';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../routers.dart';

class ServiceManager extends ChangeNotifier {
  List<Article> articles = [];

  var _page = 0; //当前软文 页数
  static const int _pageSize = 10; //软文每次加载SIZE

  List<ServiceInfo> services = [
    serviceinfo1,
    serviceinfo2,
    serviceinfo3,
    serviceinfo4,
    serviceinfo5,
    serviceinfo6,
    serviceinfo7,
    serviceinfo8
  ];

  clickService(ServiceInfo serviceInfo) {
    switch (serviceInfo.serviceId) {
      case "repairs":
        Routers.navigateTo('/repairs_list');
        break;
      case "feedback":
        Routers.navigateTo('/feedback_list');
        break;
      case "contact":
        Routers.navigateTo('/contact');
        break;
      default:
        Routers.navListPage(serviceInfo.name, serviceInfo.serviceId);
        break;
    }
  }

  /// 页面 load more
  Future<PageLoadStatus> loadMore() async {
    ApiResult result = await API.getArticleList(_page + 1, _pageSize, Flavors.appId.home_page_id);
    var callback = PageLoadStatus.canLoading;
    if (result.isSuccess()) {
      var news = result.getDataList((m) => Article.fromJson(m));
      if (news.isEmpty) {
        callback = PageLoadStatus.noMore;
      } else {
        _page++;
        articles = (news);
        callback = PageLoadStatus.canLoading;
      }
    } else {
      callback = PageLoadStatus.failed;
    }
    notifyListeners();
    return callback;
  }

  /// 页面首次加载 or 刷新
  Future<PageRefreshStatus> refresh() async {
    _page = 0;
    ApiResult result = await API.getArticleList(_page, _pageSize, "tab1");
    var callback = PageRefreshStatus.completed;
    if (result.isSuccess()) {
      var news = result.getDataList((m) => Article.fromJson(m));
      if (news.isEmpty) {
        callback = PageRefreshStatus.completed;
      } else {
        articles = [...articles]..addAll(news);
        callback = PageRefreshStatus.completed;
      }
    } else {
      callback = PageRefreshStatus.failed;
    }
    notifyListeners();
    return callback;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
