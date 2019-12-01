import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:hatchery/common/api.dart';
import 'package:hatchery/manager/beans.dart';
import 'package:flutter/material.dart';
import 'dart:collection';

class NearbyManager extends ChangeNotifier {
  List _bannerList = [
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1574975313305&di=04e13c0dfdb9694284a033758013bfe0&imgtype=0&src=http%3A%2F%2Fpic.616pic.com%2Fbg_w1180%2F00%2F06%2F93%2FwadIDUbTQt.jpg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1574975364458&di=78e0cc9ddda7bf60ba8c6bb84e08a666&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Facc85b81ca7ac4dfb790513ce7bdd01c7e9a63bc1d34a-H0QN9x_fw658",
    "https://v1.vuepress.vuejs.org/hero.png"
  ];

  UnmodifiableListView get bannerList => UnmodifiableListView(_bannerList);

  int get bannerTotal => _bannerList.length;

  @override
  void dispose() {
    super.dispose();
  }
}
