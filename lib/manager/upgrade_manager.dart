import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:hatchery/common/api.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/manager/beans.dart';
import 'dart:collection';
import 'package:url_launcher/url_launcher.dart';

class UpgradeManager extends ChangeNotifier {
  var dataLists =
      '{"code": 200,"must_update": false,"show_update": true,"update_message": "床前明月光 \\n疑是地上霜 \\n举头望明月 \\n低头思故乡","update_url": "http://dldir1.qq.com/weixin/android/weixin704android1420.apk"}';

  List<updataInfo> _updataLists = [];

  UnmodifiableListView<updataInfo> get UpdataLists =>
      UnmodifiableListView(_updataLists);

  UpgradeManager() {
    queryUpdataData();
  }

  queryUpdataData() async {
    Response response = await Api.queryUpgradeList();
    final parsed = json.decode(response.data);
    var resultCode = parsed[0]['code'] ?? "0";
    var resultData = parsed[0] ?? null;
    if (resultCode == "200" && resultData != null) {
      print('LC ###### -> $resultData');
      _updataLists = resultData
          .map<updataInfo>((value) => updataInfo.fromJson(value))
          .toList();
//      add(resultData);
      print('LC ###### -> ${_updataLists[0].updateUrl}');
    }

//    notifyListeners();
  }

  void add(updataInfo item) {
    _updataLists.add(item);
//    notifyListeners();
  }

//  Future<void> DownloadApp() {
//    if (Platform.isAndroid) {
//      gotoDownloadPage();
//    } else if (Platform.isIOS) {
//      gotoDownloadPage();
//    } else {
//      gotoDownloadPage();
//    }
//  }

  gotoDownloadPage(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
