import 'dart:async';
import 'package:dio/dio.dart';
import 'package:hatchery/common/api.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hatchery/manager/beans.dart';
import 'package:hatchery/common/tools.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:package_info/package_info.dart';
import 'package:hatchery/configs.dart';
import 'package:flutter/cupertino.dart';

class UpgradeManager {
  List<UpdateInfo> _updateLists = [];
  double finalCount;
  String result;
  var parsed;

  double get FinalCount => finalCount;

  ///先判断app生命周期内是否弹过
  isShowUpgradeCard(context) {
    sharedGetData('showUpgradeCard').then((result) {
      bool showedCard = result ?? false;
      print('##############  $showedCard');
      if (showedCard == false) {
        _queryUpdateData().then((info) {
          _checkVersion().then((status) {
            if (status) {
              _downloadFile(_updateLists[0].url, context);
            }
          });
        });
      }
    });
  }

  Future _queryUpdateData() async {
    Response response = await Api.queryUpgradeList();
    result = response.data;
    parsed = jsonDecode(result);
    var resultData = parsed['result'] ?? null;
    if (parsed['result']['verson'] != null &&
        parsed['code'] == 200 &&
        parsed['info'] == 'OK') {
      add(UpdateInfo.fromJson(resultData));
    }
  }

  void add(UpdateInfo item) {
    _updateLists.add(item);
  }

  ///下载策略
//  Future _downloadApp() async {
//    print('LC->#####${_updateLists[0].url}');
//    if (Platform.isAndroid) {
//      _downloadFile(_updateLists[0].url).then((info) {});
//    }
//  }

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

  ///存储权限申请
  Future _requestPermission() async {
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
  _downloadFile(urlPath, context) async {
    await _requestPermission().then((result) {
      sharedAddAndUpdate('showUpgradeCard', bool, true);
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
            upgradeCard(context, info);
          } on DioError catch (e) {
            print('downloadFile error---------$e');
          }
        });
      }
    });
  }

  Future _checkVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int localVersionCode = int.parse(packageInfo.buildNumber) ?? 1;
    int apiVc = int.parse(_updateLists[0].version);
    if (localVersionCode < apiVc) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> upgradeCard(context, apkPath) async {
    Timer(const Duration(seconds: UPGRADE_LOADING_TIME), () {
      return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
                  backgroundColor: Colors.white,
                  title: Text(
                    "发现新版本!",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  content: SingleChildScrollView(
                    child: Text(_updateLists[0]?.introduction ?? "修复bug"),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        '取消',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text(
                        '更新',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        OpenFile.open('$apkPath' + '/hatchery.apk');
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ) ??
                false;
          });
    });
  }
}
