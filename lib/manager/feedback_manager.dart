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

class FeedbackManager extends ChangeNotifier {
  List<FeedbackInfo> _data = [];

  String uploadUrl =
      "https://lh6.googleusercontent.com/-Dae1asfHrWc/AAAAAAAAAAI/AAAAAAAAFcg/oAo7f_B9_v8/photo.jpg?sz=328";

  UnmodifiableListView<FeedbackInfo> get data => UnmodifiableListView(_data);

  var _page = 0; //当前软文 页数
  static const int _pageSize = 20; //软文每次加载SIZE

  /// 页面 load more
  Future<PageLoadStatus> loadMore() async {
    ApiResult result = await API.getFeedback(_page + 1, _pageSize, "uid_test");
    var callback = PageLoadStatus.canLoading;
    if (result.isSuccess()) {
      var news = result.getDataList((m) => FeedbackInfo.fromJson(m));
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
    ApiResult result = await API.getFeedback(_page, _pageSize, "uid_test");
    var callback = PageRefreshStatus.completed;
    if (result.isSuccess()) {
      var news = result.getDataList((m) => FeedbackInfo.fromJson(m));
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
    Routers.navigateTo('/feedback_new');
  }

  Future<bool> submit(String title, String content, String phone) async {
    var images = <String>[];
    if (uploadUrl.isNotEmpty) {
      images.add(uploadUrl);
    }
    ApiResult result =
        await API.postFeedback(title, content, phone, "uid_test", images);
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
