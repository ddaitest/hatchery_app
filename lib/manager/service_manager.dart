import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:hatchery/common/api.dart';
import 'package:hatchery/manager/beans.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:hatchery/configs.dart';

class ServiceManager extends ChangeNotifier {
  List<ArticleDataInfo> _subjectLists = [];

  UnmodifiableListView<ArticleDataInfo> get subjectLists =>
      UnmodifiableListView(_subjectLists);

  List<SerivceTopInfo> _topList = [];

  List<Widget> topShow = [];

  UnmodifiableListView<SerivceTopInfo> get topList =>
      UnmodifiableListView(_topList);

  int get total => _subjectLists.length;

  int get topTotal => _topList.length;

  Map<String, String> getListParameters = {
    "service_id": SERVICE_ID,
    "category_id": SERVICE_TAB_ID,
    "size": FEED_SIZE,
    "cursor": '',
  };

  Map<String, String> getTopParameters = {
    "category_id": SERVICE_CATEGORY_ID,
    "size": FEED_SIZE,
  };

  String result;
  Map parsed;
  String topResult;
  Map topParsed;

  ScrollController scrollController = ScrollController();
  bool isLoading = false;

  ServiceManager() {
    queryServiceTopData().then((info) {
      for (var x in info) {
        addTop(SerivceTopInfo.fromJson(x));
      }
      notifyListeners();
    });
    queryServiceData().then((info) {
      for (var x in info) {
        add(ArticleDataInfo.fromJson(x));
      }
      notifyListeners();
    });
  }

  getMore() async {
    if (!isLoading) {
      isLoading = true;
      await Future.delayed(Duration(seconds: 0), () {
        moreQueryServiceData().then((info) {
          for (var x in info) {
            add(ArticleDataInfo.fromJson(x));
          }
          isLoading = false;
          notifyListeners();
        });
      });
    }
  }

  ///服务top数据
  Future queryServiceTopData() async {
    Response response =
        await ApiForServicePage.queryServiceTop(getTopParameters);
    topResult = response.data;
    topParsed = jsonDecode(topResult);
    var resultData = topParsed['result'] ?? null;
    print("queryServiceTopData: $topResult");
    if (topResult != null &&
        topParsed['code'] == 200 &&
        topParsed['info'] == 'OK') {
      return resultData;
    } else {
      return false;
    }
  }

  ///服务tab数据
  Future queryServiceData() async {
    Response response =
        await ApiForServicePage.queryServiceList(getListParameters);
    result = response.data;
    parsed = jsonDecode(result);
    var resultData = parsed['result'] ?? null;
    if (result != null && parsed['code'] == 200 && parsed['info'] == 'OK') {
      if (resultData.length != 0) {
        getListParameters['cursor'] = resultData.last['id'] ?? null;
      }
      return resultData;
    } else {
      return false;
    }
  }

  ///服务tab load more数据
  Future moreQueryServiceData() async {
    Response response =
        await ApiForServicePage.queryServiceList(getListParameters);
    result = response.data;
    parsed = jsonDecode(result);
    var resultData = parsed['result'] ?? null;
    if (result != null && parsed['code'] == 200 && parsed['info'] == 'OK') {
      if (resultData.length != 0) {
        getListParameters['cursor'] = resultData.last['id'] ?? null;
      }
      return resultData;
    } else {
      return false;
    }
  }

  void add(ArticleDataInfo item) {
    _subjectLists.add(item);
  }

  void addTop(SerivceTopInfo item) {
    _topList.add(item);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }
}
