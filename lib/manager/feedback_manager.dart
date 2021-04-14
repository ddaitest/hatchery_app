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
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../routers.dart';

/// API - 获取
typedef Future<ApiResult> GetData(int page, int size, String uid);

/// API - 创建
typedef Future<ApiResult> PostData(String title, String content, String phone,
    String uid, List<String> photos);

/// 解析
typedef T Parser<T>(Map<String, dynamic> value);

/// 报事报修 Manager
class RepairManager extends BaseManager {
  static GetData get = (a, b, c) => API.getReports(a, b, c);
  static PostData post = (a, b, c, d, e) => API.postFeedback(a, b, c, d, e);
  static Parser<FeedbackInfo> pp = (m) => FeedbackInfo.fromJson(m);

  RepairManager() : super(get, post, pp, "/repairs_new");
}

/// 问题反馈 Manager
class FeedbackManager extends BaseManager {
  static GetData get = (a, b, c) => API.getFeedback(a, b, c);
  static PostData post = (a, b, c, d, e) => API.postFeedback(a, b, c, d, e);
  static Parser<FeedbackInfo> pp = (m) => FeedbackInfo.fromJson(m);

  FeedbackManager() : super(get, post, pp, "/feedback_new");
}

/// 问题反馈 +报事报修 基础Manager
class BaseManager extends ChangeNotifier {
  Parser<FeedbackInfo> parser;
  GetData getApi;
  PostData postApi;
  String createPath;

  BaseManager(this.getApi, this.postApi, this.parser, this.createPath);

  List<FeedbackInfo> _data = [];

  String uploadUrl = "";

  UnmodifiableListView<FeedbackInfo> get data => UnmodifiableListView(_data);

  var _page = 0; //当前软文 页数
  static const int _pageSize = 20; //软文每次加载SIZE

  /// 页面 load more
  Future<PageLoadStatus> loadMore() async {
    ApiResult result = await getApi(_page + 1, _pageSize, "uid_test");
    var callback = PageLoadStatus.canLoading;
    if (result.isSuccess()) {
      var news = result.getDataList(parser);
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
    ApiResult result = await getApi(_page, _pageSize, "uid_test");
    var callback = PageRefreshStatus.completed;
    if (result.isSuccess()) {
      var news = result.getDataList(parser);
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

  create() {
    Routers.navigateTo(createPath);
  }

  Future<bool> submit(String title, String content, String phone) async {
    var images = <String>[];
    if (uploadUrl.isNotEmpty) {
      images.add(uploadUrl);
    }
    ApiResult result = await postApi(title, content, phone, "uid_test", images);
    return result.isSuccess();
  }

  Future<bool> uploadImage(String filePath) async {
    ApiResult result = await API.uploadImage(filePath, (count, total) {
      print("$count / $total");
    });
    if (result.isSuccess()) {
      final url = result.getData();
      if (url is String) {
        uploadUrl = url;
        notifyListeners();
      }
    }
    return result.isSuccess();
  }

  removeImage() {
    uploadUrl = "";
    notifyListeners();
  }
}
