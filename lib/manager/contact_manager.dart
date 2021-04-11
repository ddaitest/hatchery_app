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

class ContactManager extends ChangeNotifier {
  List<Contact> _contacts = [];

  UnmodifiableListView<Contact> get contacts => UnmodifiableListView(_contacts);

  var _page = 0; //当前软文 页数
  static const int _pageSize = 20; //软文每次加载SIZE

  /// 页面 load more
  Future<PageLoadStatus> loadMore() async {
    ApiResult result = await API.getContacts(_page + 1, _pageSize);
    var callback = PageLoadStatus.canLoading;
    if (result.isSuccess()) {
      var news = result.getDataList((m) => Contact.fromJson(m));
      if (news.isEmpty) {
        callback = PageLoadStatus.noMore;
      } else {
        _page++;
        _contacts.addAll(news);
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
    ApiResult result = await API.getContacts(_page, _pageSize);
    var callback = PageRefreshStatus.completed;
    if (result.isSuccess()) {
      var news = result.getDataList((m) => Contact.fromJson(m));
      if (news.isEmpty) {
        callback = PageRefreshStatus.completed;
      } else {
        _contacts.clear();
        _contacts.addAll(news);
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
