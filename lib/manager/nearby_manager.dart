import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:hatchery/common/api.dart';
import 'package:hatchery/manager/beans.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:hatchery/configs.dart';

class NearbyManager extends ChangeNotifier {
  List _bannerList = [
    "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2930759379,1348658930&fm=26&gp=0.jpg",
    "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=715079091,2714859735&fm=26&gp=0.jpg",
    "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2930759379,1348658930&fm=26&gp=0.jpg",
  ];

  List get bannerList => _bannerList;

  int get bannerTotal => _bannerList.length;

  List<NearbyListInfo> _subjectLists = [];

  UnmodifiableListView<NearbyListInfo> get subjectLists =>
      UnmodifiableListView(_subjectLists);

  int get total => _subjectLists.length;

  Map<String, String> getParameters = {
    "service_id": SERVICE_ID,
    "category_id": SERVICE_TAB_NUMBER,
    "size": FEED_SIZE,
    "cursor": '',
  };

  String result;
  var parsed;
  ScrollController scrollController = ScrollController();
  bool isLoading = false;

  NearbyManager() {
    queryServiceData().then((info) {
      for (var x in info) {
        add(NearbyListInfo.fromJson(x));
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
            add(NearbyListInfo.fromJson(x));
          }
          isLoading = false;
          notifyListeners();
        });
      });
    }
  }

  ///服务tab数据
  Future queryServiceData() async {
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

  void add(NearbyListInfo item) {
    _subjectLists.add(item);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }
}
