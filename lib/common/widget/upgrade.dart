import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hatchery/manager/upgrade_manager.dart';
import 'package:flutter/cupertino.dart';

///升级弹窗ui
Future<void> upgradeCard(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return ChangeNotifierProvider(
          builder: (context) => UpgradeManager(),
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
                  child: Text(manager.UpdataLists[0]?.updateMessage ?? ""),
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
                      manager.DownloadApp(manager.UpdataLists[0].android_url,
                          manager.UpdataLists[0].ios_url);
                      Navigator.of(context).pop();
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
