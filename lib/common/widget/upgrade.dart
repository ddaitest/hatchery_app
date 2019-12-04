import 'package:flutter/material.dart';
import 'package:hatchery/business/home/phone_numbers.dart';
import 'package:hatchery/business/home/report_something.dart';
import 'package:provider/provider.dart';
import 'package:hatchery/manager/upgrade_manager.dart';
import 'package:hatchery/manager/app_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:hatchery/common/widget/webview_common.dart';

///升级弹窗ui
upgradeCard(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return ChangeNotifierProvider(
          builder: (context) => UpgradeManager(),
          child: Consumer<UpgradeManager>(
            builder: (context, manager, child) => AlertDialog(
              title: Text(
                "发现新版本!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: SingleChildScrollView(
                child: Text(manager.UpdataLists[0].updateMessage),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    '取消',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text(
                    '更新',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ));
    },
  );
}
