import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hatchery/manager/upgrade_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:connectivity/connectivity.dart';
import 'package:progress_dialog/progress_dialog.dart';

///升级弹窗ui
Future<void> upgradeCard(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return ChangeNotifierProvider(
          create: (context) => UpgradeManager(),
          child: Consumer<UpgradeManager>(builder: (xx, manager, yy) {
            if (manager.total != 0) {
              return AlertDialog(
                title: Text(
                  "发现新版本!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                content: SingleChildScrollView(
                  child: Text(manager.UpdataLists[0]?.updateMessage ?? "修复bug"),
                ),
                actions: <Widget>[
                  _mustBeClose(context, manager),
                  FlatButton(
                    child: Text(
                      '更新',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      _checkNetworkType().then((info) {
                        print('LC- >' + info.toString());
                        if (info) {
                          Navigator.of(context).pop();
                          manager.DownloadApp(manager.UpdataLists[0].ios_url);
                        } else {
                          Navigator.of(context).pop();
                          CellularDataCheck(context, manager);
                        }
                      });
                    },
                  ),
                ],
              );
            } else {
              return CupertinoActivityIndicator();
            }
          }));
    },
  );
}

Future _checkNetworkType() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return false;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
}

Future<void> CellularDataCheck(BuildContext context, cdc) async {
  return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "流量提醒!",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: SingleChildScrollView(
            child: Text('当前使用的是移动数据, 是否升级?'),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                '确认',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                cdc.DownloadApp(cdc.UpdataLists[0].ios_url);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                '取消',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      });
}

_mustBeClose(context, mm) {
  bool choice = mm.UpdataLists[0].mustUpdate ?? true;
  if (choice == false) {
    return FlatButton(
      child: Text(
        '取消',
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
