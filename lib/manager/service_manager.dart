import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:hatchery/api/API.dart';
import 'package:hatchery/api/ApiResult.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/common/PageStatus.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/api/entity.dart';
import 'dart:collection';
import 'package:hatchery/configs.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../routers.dart';

class ServiceManager extends ChangeNotifier {
  List<Article> _articles = [];

  UnmodifiableListView<Article> get articles => UnmodifiableListView(_articles);

  var _page = 0; //当前软文 页数
  static const int _pageSize = 10; //软文每次加载SIZE

  List<ServiceInfo> services = [
    //TODO fix
    ServiceInfo('images/image1.png',"问题反馈", "feedback"),
    ServiceInfo('images/image2.png',"报事报修", "repairs"),
    ServiceInfo('images/image3.png',"联系物业", "contact"),
    ServiceInfo('images/image4.png',"便民服务", "service_1"),
    ServiceInfo('images/image1.png',"家电维修", "service_2"),
    ServiceInfo('images/image2.png',"房屋租售", "service_3"),
    ServiceInfo('images/image3.png',"教育培训", "service_4"),
    ServiceInfo('images/image4.png',"开锁换锁", "service_5"),
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
        Routers.navListPage(serviceInfo.name,serviceInfo.serviceId);
        break;
    }
  }

  /// 页面 load more
  Future<PageLoadStatus> loadMore() async {
    ApiResult result = await API.getArticleList(_page + 1, _pageSize, "tab1");
    var callback = PageLoadStatus.canLoading;
    if (result.isSuccess()) {
      var news = result.getDataList((m) => Article.fromJson(m));
      if (news.isEmpty) {
        callback = PageLoadStatus.noMore;
      } else {
        _page++;
        _articles.addAll(news);
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
        _articles.clear();
        _articles.addAll(news);
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
