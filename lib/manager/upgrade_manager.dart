import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:hatchery/common/api.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/manager/beans.dart';
import 'dart:collection';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

class UpgradeManager extends ChangeNotifier {
  List<updataInfo> _updataLists = [];

  UnmodifiableListView<updataInfo> get UpdataLists =>
      UnmodifiableListView(_updataLists);

  int get total => _updataLists.length;
  double finalCount;
  String result;
  var parsed;

  double get FinalCount => finalCount;

  UpgradeManager() {
    queryUpdataData();
  }

  queryUpdataData() async {
    Response response = await Api.queryUpgradeList();
    result = response.data;
    parsed = jsonDecode(result);
    var resultData = parsed['result'] ?? null;
    print('resultData $resultData');
    if (result != null && parsed['code'] == 200 && parsed['info'] == 'OK') {
      add(updataInfo.fromJson(resultData));
    } else {
      return null;
    }
  }

  void add(updataInfo item) {
    _updataLists.add(item);
    notifyListeners();
  }

  ///下载策略
  Future downloadApp() async {
    print('LC->#####${_updataLists[0].url}');
    if (Platform.isAndroid) {
      _downloadFile(_updataLists[0].url, _localPath());
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
//  _gotoAppStorePage(String url) async {
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      throw 'Could not launch $url';
//    }
//  }

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
      if (result) {
        _localPath().then((info) async {
          Dio dio = Dio();
          try {
            print('LC -> ' + '$info' + '/hatchery.apk');
            await dio.download(urlPath, '$info' + '/hatchery.apk',
                onReceiveProgress: (int count, int total) {
              finalCount = (((count / total) * 100).toInt()).toDouble();

              ///进度
              print("$FinalCount%");
            });
            OpenFile.open('$info' + '/hatchery.apk');
          } on DioError catch (e) {
            print('downloadFile error---------$e');
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
