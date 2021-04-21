import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:hatchery/api/API.dart';
import 'package:hatchery/api/ApiResult.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/common/AppContext.dart';
import 'package:hatchery/common/PageStatus.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'dart:collection';
import '../routers.dart';

class NearbyManager extends ChangeNotifier {
  List<Article> articles = [];

  List<BannerInfo> banners = [];

  var _page = 0; //当前软文 页数
  static const int _pageSize = 10; //软文每次加载SIZE

  Future<PageRefreshStatus> init() {
    refreshBanner();
    return refresh();
  }

  /// 加载 banner
  Future<PageRefreshStatus> refreshBanner() async {
    _page = 0;
    ApiResult result =
        await API.getBannerList(_page, _pageSize, Flavors.appId.nearby_page_id);
    var callback = PageRefreshStatus.completed;
    if (result.isSuccess()) {
      var news = result.getDataList((m) => BannerInfo.fromJson(m));
      if (news.isEmpty) {
        callback = PageRefreshStatus.completed;
      } else {
        banners = news;
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
    ApiResult result = await API.getArticleList(
        _page + 1, _pageSize, Flavors.appId.nearby_page_id);
    var callback = PageLoadStatus.canLoading;
    if (result.isSuccess()) {
      var news = result.getDataList((m) => Article.fromJson(m));
      if (news.isEmpty) {
        callback = PageLoadStatus.noMore;
      } else {
        _page++;
        articles = [...articles]..addAll(news);
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
    ApiResult result = await API.getArticleList(
        _page, _pageSize, Flavors.appId.home_page_id);
    var callback = PageRefreshStatus.completed;
    if (result.isSuccess()) {
      var news = result.getDataList((m) => Article.fromJson(m));
      if (news.isEmpty) {
        callback = PageRefreshStatus.completed;
      } else {
        // _articles.clear();
        articles = news;
        // _articles.addAll(news);
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
