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
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

class UpgradeManager extends ChangeNotifier {
  List<updataInfo> _updataLists = [];

  UnmodifiableListView<updataInfo> get UpdataLists =>
      UnmodifiableListView(_updataLists);

  int get total => _updataLists.length;
  double finalCount;

  double get FinalCount => finalCount;

  UpgradeManager() {
    _localPath();
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

  ///下载策略
  Future<void> DownloadApp(iosUrl) {
    if (Platform.isAndroid) {
      _downloadFile(_updataLists[0].android_url, _localPath());
    } else if (Platform.isIOS) {
      _gotoAppStorePage(iosUrl);
    } else {
      print('LC -> 平台判定失败');
    }
  }

  ///获取本地路径
  Future _localPath() async {
    try {
      var appDocDir = (await getExternalStorageDirectory()).path;
      return appDocDir;
    } catch (err) {
      print(err);
    }
  }

  ///ios跳转至Appstore
  _gotoAppStorePage(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  ///网络权限申请
  Future requestPermission() async {
    // 申请权限
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);

    // 申请结果
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);

    if (permission == PermissionStatus.granted) {
      print("有权限");
      return true;
    } else {
      print("权限申请失败");
      return false;
    }
  }

  ///下载前需先拿到path
  _downloadFile(urlPath, localPath) async {
    requestPermission().then((result) {
      if (result.toString() == 'true') {
        _localPath().then((info) async {
          Dio dio = Dio();
          Response response;
          try {
            print('LC -> ' + '$info' + '/hatchery.apk');
            response = await dio.download(urlPath, '$info' + '/hatchery.apk',
                onReceiveProgress: (int count, int total) {
              finalCount = (((count / total) * 100).toInt()).toDouble();

              ///进度
              print("$FinalCount%");
            });
            OpenFile.open('$info' + '/hatchery.apk');
          } on DioError catch (e) {
            print('downloadFile error---------$e');
          }
          return response.data;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
