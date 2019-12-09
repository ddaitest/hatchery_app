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

  @override
  void dispose() {
    super.dispose();
  }
}
