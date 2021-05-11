import 'package:flutter/material.dart';
import 'package:hatchery/common/utils.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:hatchery/common/AppContext.dart';

void showDialogFunction(UpgradeInfo upgradeInfo) async {
  return showDialog<void>(
    context: App.navState.currentContext!,
    barrierDismissible: upgradeInfo.upgradeType == 1 ? true : false,
    builder: (context) {
      return AlertDialog(
        scrollable: true,
        title: Text("${upgradeInfo.title}"),
        //title 的内边距，默认 left: 24.0,top: 24.0, right 24.0
        content: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('更新说明:'),
              Text('${upgradeInfo.newFeature}'),
            ],
          ),
        ),
        actions: <Widget>[
          upgradeInfo.upgradeType == 1
              ? TextButton(
                  child: Text("下次再说"),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                )
              : Container(),
          TextButton(
            child: Text("立即更新"),
            onPressed: () {
              //关闭 返回true
              Navigator.of(context).pop(true);
              launchUrl(upgradeInfo.apkUrl!);
            },
          ),
        ],
      );
    },
  );
}
