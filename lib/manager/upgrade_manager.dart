import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/manager/beans.dart';
import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:hatchery/common/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class UpgradeManager extends ChangeNotifier {
  var dataLists =
      '[{"code": "200","must_update": false,"show_update": true,"update_message": "test","update_url": "http://dldir1.qq.com/weixin/android/weixin704android1420.apk"}]';

  List<updataiInfo> _updataLists = [];

  UnmodifiableListView<updataiInfo> get UpdataLists =>
      UnmodifiableListView(_updataLists);

  UpgradeManager() {
    queryUpdataData();
  }

  queryUpdataData() async {
    final parsed = json.decode(dataLists);
    _updataLists =
        parsed.map<updataiInfo>((json) => updataiInfo.fromJson(json)).toList();
    print('LC -> ${_updataLists[0].updateUrl}');
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
