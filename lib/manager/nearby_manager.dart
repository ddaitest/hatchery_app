import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:hatchery/common/api.dart';
import 'package:hatchery/manager/beans.dart';
import 'package:flutter/material.dart';
import 'dart:collection';

class NearbyManager extends ChangeNotifier {
  List _bannerList = [
    "https://v1.vuepress.vuejs.org/hero.png",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1574975313305&di=04e13c0dfdb9694284a033758013bfe0&imgtype=0&src=http%3A%2F%2Fpic.616pic.com%2Fbg_w1180%2F00%2F06%2F93%2FwadIDUbTQt.jpg",
    "https://v1.vuepress.vuejs.org/hero.png",
  ];

  UnmodifiableListView get bannerList => UnmodifiableListView(_bannerList);

  int get bannerTotal => _bannerList.length;

  List<IgnDataInfo> _subjectLists = [];

  UnmodifiableListView<IgnDataInfo> get subjectLists =>
      UnmodifiableListView(_subjectLists);

  int get total => _subjectLists.length;

  NearbyManager({int num = 1}) {
    queryIgnData(num);
  }

//  getListData(String num) async {
//    await queryIgnData();
//    print('LC -> ${_subjectLists[0].title}');
//  }

  ///附近tab数据
  queryIgnData(int num) async {
    Response response = await ApiForNearby.queryIgnList(num.toString());
    if (response.data != null) {
      final parsed = json.decode(response.data)['data'] ?? null;
//      var resultCode = parsed['code'] ?? 0;
      for (var x in parsed) {
        add(IgnDataInfo.fromJson(x));
      }
//      print("LC->#### ${_phoneNumbersList}");
    }
  }

  void add(IgnDataInfo item) {
    _subjectLists.add(item);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
