import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:hatchery/common/api.dart';
import 'package:hatchery/manager/beans.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:hatchery/configs.dart';

class ServiceManager extends ChangeNotifier {
  List<ServiceListInfo> _subjectLists = [];

  UnmodifiableListView<ServiceListInfo> get subjectLists =>
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

  ServiceManager() {
    queryServiceData().then((info) {
      for (var x in info) {
        add(ServiceListInfo.fromJson(x));
      }
    });
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

  ///服务tab数据
  Future queryServiceData() async {
    Response response = await ApiForServicePage.queryServiceList(getParameters);
    result = response.data;
    parsed = jsonDecode(result);
    var resultData = parsed['result'] ?? null;
    if (result != null && parsed['code'] == 200 && parsed['info'] == 'OK') {
      getParameters['cursor'] = resultData.last['id'] ?? '';
      print("cursor#######${resultData.last['id']}");
      return resultData;
    } else {
      return false;
    }
  }

  void add(ServiceListInfo item) {
    _subjectLists.add(item);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
