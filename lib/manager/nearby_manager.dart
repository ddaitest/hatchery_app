import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:hatchery/common/api.dart';
import 'package:hatchery/manager/beans.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:hatchery/configs.dart';

class NearbyManager extends ChangeNotifier {
  List<Article> _subjectLists = [];

  List<BannerInfo> _bannerLists = [];

  UnmodifiableListView<Article> get subjectLists =>
      UnmodifiableListView(_subjectLists);

  UnmodifiableListView<BannerInfo> get bannerLists =>
      UnmodifiableListView(_bannerLists);

  ScrollController scrollController = ScrollController();

  int get bannerTotal => _bannerLists.length;

  int get total => _subjectLists.length;

  Map<String, String> getParameters = {
    "service_id": SERVICE_ID,
    "category_id": SERVICE_TAB_ID,
    "size": FEED_SIZE,
    "cursor": '',
  };

  Map<String, String> getBannerParameters = {
    "category": NEARBY_CATEGORY_ID,
  };

  String result;
  Map parsed;
  bool isLoading = false;

  NearbyManager() {
    queryNearbyBannerData().then((bannerInfo) {
      for (var i in bannerInfo) {
        addBanner(BannerInfo.fromJson(i));
      }
      notifyListeners();
    });
    queryNearbyData().then((info) {
      for (var x in info) {
        add(Article.fromJson(x));
      }
      notifyListeners();
    });
  }

  getMore() async {
    if (!isLoading) {
      isLoading = true;
      await Future.delayed(Duration(seconds: 1), () {
        moreQueryServiceData().then((info) {
          for (var x in info) {
            add(Article.fromJson(x));
          }
          isLoading = false;
          notifyListeners();
        });
      });
    }
  }

  ///周边banner数据
  Future queryNearbyBannerData() async {
    Response response = await ApiForBanner.queryBannerList(getBannerParameters);
    result = response.data;
    parsed = jsonDecode(result);
    var resultData = parsed['result'] ?? null;
    if (result != null && parsed['code'] == 200 && parsed['info'] == 'OK') {
      return resultData;
    } else {
      return false;
    }
  }

  ///周边tab数据
  Future queryNearbyData() async {
    Response response = await ApiForNearbyPage.queryNearbyList(getParameters);
    result = response.data;
    parsed = jsonDecode(result);
    var resultData = parsed['result'] ?? null;
    if (result != null && parsed['code'] == 200 && parsed['info'] == 'OK') {
      if (resultData.length != 0) {
        getParameters['cursor'] = resultData.last['id'] ?? null;
      }
      return resultData;
    } else {
      return false;
    }
  }

  Future moreQueryServiceData() async {
    print('moreQueryServiceData');
    Response response = await ApiForNearbyPage.queryNearbyList(getParameters);
    result = response.data;
    parsed = jsonDecode(result);
    var resultData = parsed['result'] ?? null;
    if (result != null && parsed['code'] == 200 && parsed['info'] == 'OK') {
      if (resultData.length != 0) {
        getParameters['cursor'] = resultData.last['id'] ?? null;
      }
      return resultData;
    } else {
      return false;
    }
  }

  void add(Article item) {
    _subjectLists.add(item);
  }

  void addBanner(BannerInfo item) {
    _bannerLists.add(item);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }
}
