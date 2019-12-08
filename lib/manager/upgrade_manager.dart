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
  List<updataInfo> _updataLists = [];

  UnmodifiableListView<updataInfo> get UpdataLists =>
      UnmodifiableListView(_updataLists);

  int get total => _updataLists.length;

  UpgradeManager() {
    queryUpdataData();
  }

  queryUpdataData() async {
    Response response = await Api.queryUpgradeList();
    final parsed = json.decode(response.data)[0];
    var resultCode = parsed['code'] ?? 0;
    var resultData = parsed ?? null;
    if (resultCode == 200 && resultData != null) {
      add(updataInfo.fromJson(resultData));
    }
  }

  void add(updataInfo item) {
    _updataLists.add(item);
    notifyListeners();
  }

  Future<void> DownloadApp(android_url, ios_url) {
    if (Platform.isAndroid) {
      gotoDownloadPage(android_url);
    } else if (Platform.isIOS) {
      gotoDownloadPage(ios_url);
    } else {
      gotoDownloadPage(android_url);
    }
  }

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
