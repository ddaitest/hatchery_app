import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hatchery/manager/app_manager.dart';
import 'package:hatchery/manager/splash_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:hatchery/manager/beans.dart';

class NearbyTab extends StatefulWidget {
  @override
  NearbyTabState createState() => NearbyTabState();
}

class NearbyTabState extends State<NearbyTab> {
  var subjects = [];
  @override
  void initState() {
    super.initState();
    getListData();
  }

  getListData() async {
    subjects = await AppManager().queryNearbyData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => AppManager(),
      child: _nearbyPage(context),
    );
  }

  _nearbyPage(BuildContext context) {
    return Consumer<AppManager>(
      builder: (context, manager, child) => Scaffold(
          body: Column(
        children: <Widget>[
          Container(
            height: 80,
            decoration: BoxDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _topButtons(Icons.account_balance, Colors.black,
                    manager.NearbyTopMap["0"], Colors.black, null),
                _topButtons(Icons.live_help, Colors.black,
                    manager.NearbyTopMap["1"], Colors.black, null),
                _topButtons(Icons.android, Colors.black,
                    manager.NearbyTopMap["2"], Colors.black, null),
                _topButtons(Icons.language, Colors.black,
                    manager.NearbyTopMap["3"], Colors.black, null),
              ],
            ),
          ),
          Container(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _topButtons(Icons.account_balance, Colors.black,
                    manager.NearbyTopMap["4"], Colors.black, null),
                _topButtons(Icons.live_help, Colors.black,
                    manager.NearbyTopMap["5"], Colors.black, null),
                _topButtons(Icons.android, Colors.black,
                    manager.NearbyTopMap["6"], Colors.black, null),
                _topButtons(Icons.language, Colors.black,
                    manager.NearbyTopMap["7"], Colors.black, null),
              ],
            ),
          ),
          Divider(
            height: 2,
            indent: 10,
            endIndent: 10,
            color: Colors.grey[400],
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width - 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Text(
                        "| ",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                            fontSize: 25),
                      ),
                      Text(
                        "推荐",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 15,
                  ),
                  onTap: null,
                ),
              ],
            ),
          ),
          getListViewContainer(),
        ],
      )),
    );
  }

  getListViewContainer() {
    if (subjects.length == 0) {
      //loading
      return CupertinoActivityIndicator();
    }
    return ListView.builder(
        //item 的数量
        itemCount: subjects.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              getItemContainerView(subjects[index]),
              //下面的灰色分割线
              Container(
                height: 10,
                color: Color.fromARGB(255, 234, 233, 234),
              )
            ],
          );
        });
  }

  getItemContainerView(var subject) {
    var imgUrl = subject['images']['medium'];
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          getImage(imgUrl),
        ],
      ),
    );
  }

  getImage(var imgUrl) {
    return Container(
      decoration: BoxDecoration(
          image:
              DecorationImage(image: NetworkImage(imgUrl), fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      margin: EdgeInsets.only(left: 8, top: 3, right: 8, bottom: 3),
      width: 100.0,
    );
  }

  _topButtons(IconName, IconColor, String name, nameColor, tapValue) {
    return MaterialButton(
      onPressed: tapValue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            IconName,
            size: 35,
            color: IconColor,
          ),
          Text(
            name,
            style: TextStyle(color: nameColor, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
