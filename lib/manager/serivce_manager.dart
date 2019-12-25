import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:hatchery/common/api.dart';
import 'package:hatchery/manager/beans.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:hatchery/common/widget/upgrade.dart';

class SeriveManager extends ChangeNotifier {
  List<ServiceListInfo> _subjectLists = [];

  UnmodifiableListView<ServiceListInfo> get subjectLists =>
      UnmodifiableListView(_subjectLists);

  int get total => _subjectLists.length;

  SeriveManager() {
    getListData(0);
  }

  ///服务tab顶部
  var ServiceTopMap = {
    "0": "物业服务",
    "1": "家电维修",
    "2": "保姆月嫂",
    "3": "洗车",
    "4": "便民服务",
    "5": "房屋租售",
    "6": "各种服务",
    "7": "其他",
  };

  showUpgradeCard(value) {
    upgradeCard(value);
  }

  getListData(int num) async {
    await queryServiceData(num);
    print('LC -> ${_subjectLists[0].title}');
  }

  ///服务tab数据
  queryServiceData(int num) async {
    Response response = await ApiForServicePage.queryServiceList();
    final parsed = json.decode(response.data);
    var resultCode = parsed['code'] ?? 0;
    var resultData = parsed['result'][num]['content'] ?? null;
    if (resultCode == 200 && resultData != null) {
      _subjectLists = resultData
          .map<ServiceListInfo>((json) => ServiceListInfo.fromJson(json))
          .toList();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
