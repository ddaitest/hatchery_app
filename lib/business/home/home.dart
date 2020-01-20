import 'package:flutter/material.dart';
import 'package:hatchery/business/home/home_tab.dart';
import 'package:hatchery/business/nearby/nearby_tab.dart';
import 'package:hatchery/business/service/service_tab.dart';
import 'package:hatchery/flavors/default.dart';
import 'package:hatchery/configs.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:hatchery/test/TestSilver.dart';
import 'package:hatchery/test/test_provider.dart';
//import 'package:hatchery/test/test_page.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int _tabIndex = 0;
  var tabImages;
  var appBarTitles = ['首页', '服务', '周边'];
  var _pageController;

  final List<Widget> tabBodies = [
    HomeTab(),
//    TestProvider(),
//    TestSilverTab(),
    ServiceTab(),
    NearbyTab(),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          body: PageView(
            controller: _pageController,
            children: tabBodies,
            onPageChanged: (index) {
              setState(() {
                _tabIndex = index;
              });
            },
          ),
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              COMMUNITY_NAME,
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text(appBarTitles[0])),
              BottomNavigationBarItem(
                  icon: Icon(Icons.room_service), title: Text(appBarTitles[1])),
              BottomNavigationBarItem(
                  icon: Icon(Icons.near_me), title: Text(appBarTitles[2])),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: _tabIndex,
            iconSize: 24.0,
            //点击事件
            onTap: (index) {
              setState(() {
                _tabIndex = index;
              });
              _pageController.animateToPage(index,
                  duration: Duration(milliseconds: 500),
                  curve: ElasticOutCurve(4));
            },
          )),
    );
  }

  ///主界面back弹窗
  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "确定退出吗?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: SingleChildScrollView(
              child: Text("退出后将不能收到最新的社区信息"),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  '是',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                onPressed: () => Navigator.of(context).pop(true),
              ),
              FlatButton(
                child: Text(
                  '否',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                onPressed: () => Navigator.of(context).pop(false),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<void> exitApp() async {
    if (Platform.isAndroid) {
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } else if (Platform.isIOS) {
      exit(0);
    } else {
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      exit(0);
    }
  }
}
