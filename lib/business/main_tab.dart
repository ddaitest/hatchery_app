import 'package:flutter/material.dart';
import 'package:hatchery/business/home/home.dart';
import 'package:hatchery/business/nearby/nearby_tab.dart';
import 'package:hatchery/business/service/service_tab.dart';
import 'package:hatchery/flavors/default.dart';
import 'package:hatchery/configs.dart';
import 'package:hatchery/common/utils.dart';
import 'package:flutter/services.dart';
import 'package:hatchery/test/TestSilver.dart';
import 'package:hatchery/test/test_provider.dart';

class MainTab extends StatefulWidget {
  @override
  MainTabState createState() => MainTabState();
}

class MainTabState extends State<MainTab> {
  bool nextKickBackExitApp = false;
  int _tabIndex = 0;
  List<String> bottomBarTitles = ['首页', '服务', '周边'];

  List<Widget> _tabBodies = [ ServiceTab(), HomePage(),NearbyTab()];
  late PageController _pageController;

  @override
  void initState() {
    _pageController =
        PageController(initialPage: this._tabIndex, keepPage: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              COMMUNITY_NAME,
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            elevation: 0,
          ),
          body: SafeArea(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              children: _tabBodies,
              controller: _pageController,
            ),
          ),
          backgroundColor: Colors.white,
          bottomNavigationBar: Container(
              width: MediaQuery.of(context).size.width,
              child: BottomNavigationBar(
                selectedFontSize: 14.0,
                unselectedFontSize: 14.0,
                items: <BottomNavigationBarItem>[
                  _bottomBarTitlesTabBar(Icons.home_outlined, Icons.home, 0),
                  _bottomBarTitlesTabBar(
                      Icons.room_service_outlined, Icons.room_service, 1),
                  _bottomBarTitlesTabBar(
                      Icons.near_me_outlined, Icons.near_me, 2),
                ],
                type: BottomNavigationBarType.fixed,
                currentIndex: _tabIndex,
                iconSize: 24.0,
                //点击事件
                onTap: (index) {
                  setState(() {
                    print("DEBUG=>$index");
                    _tabIndex = index;
                    _pageController.jumpToPage(index);
                  });
                },
              ))),
    );
  }

  BottomNavigationBarItem _bottomBarTitlesTabBar(
      IconData unSelectIconName, IconData selectedIconName, int barTitleIndex) {
    return BottomNavigationBarItem(
      icon: Icon(unSelectIconName, size: 30.0),
      activeIcon: Icon(selectedIconName, size: 30.0),
      label: bottomBarTitles[barTitleIndex],
    );
  }

  Future<bool> _onWillPop() async {
    if (nextKickBackExitApp) {
      exitApp();
      return true;
    } else {
      showToast('再按一次退出APP');
      nextKickBackExitApp = true;
      Future.delayed(
        const Duration(seconds: 2),
        () => nextKickBackExitApp = false,
      );
      return false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
