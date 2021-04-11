import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/api/ApiResult.dart';
import 'package:hatchery/common/PageStatus.dart';

typedef Future<ApiResult> CallAPI(int page, int size);

typedef T EntityParser<T>(Map<String, dynamic> value);

enum ListPageType { Notice, Article }

class ListPageManager<T> extends ChangeNotifier {
  List<T> _data = [];

  UnmodifiableListView<T> get data => UnmodifiableListView(_data);

  var _page = 0; //当前软文 页数
  static const int _pageSize = 20; //软文每次加载SIZE

  CallAPI api;
  EntityParser<T> parser;


  ListPageManager(this.api, this.parser);

  /// 页面 load more
  Future<PageLoadStatus> loadMore() async {
    ApiResult result = await api(_page + 1, _pageSize);
    var callback = PageLoadStatus.canLoading;
    if (result.isSuccess()) {
      var news = result.getDataList((m) => parser(m));
      if (news.isEmpty) {
        callback = PageLoadStatus.noMore;
      } else {
        _page++;
        _data.addAll(news);
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
    ApiResult result = await api(_page, _pageSize);
    var callback = PageRefreshStatus.completed;
    if (result.isSuccess()) {
      var news = result.getDataList((m) => parser(m));
      if (news.isEmpty) {
        callback = PageRefreshStatus.completed;
      } else {
        _data.clear();
        _data.addAll(news);
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
