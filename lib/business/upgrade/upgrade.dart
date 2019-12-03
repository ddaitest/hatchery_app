import 'package:flutter/material.dart';
import 'package:hatchery/business/home/phone_numbers.dart';
import 'package:hatchery/business/home/report_something.dart';
import 'package:provider/provider.dart';
import 'package:hatchery/manager/upgrade_manager.dart';
import 'package:hatchery/manager/app_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:hatchery/common/widget/webview_common.dart';

//class UpdataPage extends StatefulWidget {
//  @override
//  UpdataState createState() => UpdataState();
//}
//
//class UpdataState extends State<UpdataPage> {
//  @override
//  Widget build(BuildContext context) {
//    return ChangeNotifierProvider(
//      builder: (context) => UpgradeManager(),
//      child: bodyView(context),
//    );
//  }
//}

//bodyView(BuildContext context) {
//  return Consumer<UpgradeManager>(builder: (context, manager, child) {
//    return upgradeCard();
//  });
//}

///升级弹窗ui
upgradeCard(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            height: 400,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage('images/Upgrade_Card.png'),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomLeft,
                  margin: EdgeInsets.only(left: 30.0, top: 180.0),
                  child: Text(
                    "ttttttt",
                    textAlign: TextAlign.left,
                    softWrap: true,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(15, 42, 15, 40),
                  child: MaterialButton(
                    minWidth: 250,
                    height: 50,
                    color: Colors.blue,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Text(
                      '立即更新',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ));
    },
  );
}
