import 'package:flutter/material.dart';
import 'package:hatchery/business/home/home_tab.dart';
import 'package:hatchery/business/nearby/nearby_tab.dart';
import 'package:hatchery/business/service/service_tab.dart';
import 'package:hatchery/flavors/default.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _tabIndex = 0;
  var tabImages;
  var appBarTitles = ['首页', '服务', '周边'];
  var _pageController;

  final List<Widget> tabBodies = [
    HomeTab(),
    ServiceTab(),
    NearbyTab(),
  ];

  @override
  void initState() {
    _pageController = new PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageController,
          children: tabBodies,
          onPageChanged: (index) {
            _tabIndex = index;
          },
        ),
        appBar: AppBar(
          title: Text(
            Strings().title,
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
        ));
  }
}
