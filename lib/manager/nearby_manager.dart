import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:hatchery/api/API.dart';
import 'package:hatchery/api/ApiResult.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/common/AppContext.dart';
import 'package:hatchery/common/PageStatus.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import '../routers.dart';

class NearbyManager extends ChangeNotifier {
  final String serviceId = "tab3";

  List<Article> _articles = [];

  UnmodifiableListView<Article> get articles => UnmodifiableListView(_articles);

  List<BannerInfo> _banners = [];

  UnmodifiableListView<BannerInfo> get banners =>
      UnmodifiableListView(_banners);

  var _page = 0; //当前软文 页数
  static const int _pageSize = 10; //软文每次加载SIZE

  Future<PageRefreshStatus> init() {
    refreshBanner();
    return refresh();
  }

  /// 加载 banner
  Future<PageRefreshStatus> refreshBanner() async {
    _page = 0;
    ApiResult result = await API.getBannerList(_page, _pageSize, serviceId);
    var callback = PageRefreshStatus.completed;
    if (result.isSuccess()) {
      var news = result.getDataList((m) => BannerInfo.fromJson(m));
      if (news.isEmpty) {
        callback = PageRefreshStatus.completed;
      } else {
        _banners.clear();
        _banners.addAll(news);
        callback = PageRefreshStatus.completed;
      }
    } else {
      callback = PageRefreshStatus.failed;
    }
    notifyListeners();
    return callback;
  }

  /// 页面 load more
  Future<PageLoadStatus> loadMore() async {
    ApiResult result =
        await API.getArticleList(_page + 1, _pageSize, serviceId);
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
    ApiResult result = await API.getArticleList(_page, _pageSize, serviceId);
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

  void clickBanner(BannerInfo value) {
    Routers.navWebView(value.redirectUrl);
  }
}
