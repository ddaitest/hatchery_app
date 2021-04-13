import 'package:flutter/material.dart';
import 'package:hatchery/business/home/home.dart';
import 'package:hatchery/business/nearby/nearby_tab.dart';
import 'package:hatchery/business/service/service_tab.dart';
import 'package:hatchery/common/widget/app_bar.dart';
import 'package:hatchery/flavors/default.dart';
import 'package:hatchery/common/utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  List<Widget> _tabBodies = [HomePage(), ServiceTab(), NearbyTab()];
  late PageController _pageController;

  @override
  void initState() {
    _pageController =
        PageController(initialPage: this._tabIndex, keepPage: true);
    super.initState();
  }

  void handleClick(String value) {
    switch (value) {
      case '关于物业':
        //TODO
        break;
      case '商务合作':
        //TODO
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
<<<<<<< HEAD
          appBar: AppBar(
            title: Text(
              StringsInfo().community_name,
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
=======
          appBar: AppBarFactory.getMain(COMMUNITY_NAME, actions: [
            PopupMenuButton<String>(
              onSelected: handleClick,
              icon: Icon(Icons.more_vert, color: Colors.blue),
              itemBuilder: (BuildContext context) {
                return {'关于物业', '商务合作'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
>>>>>>> e602b1e13a7a440ff56b43ab1945480e10761eab
            ),
          ]),
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
                selectedLabelStyle: TextStyle(
                    fontSize: 10.0.sp,
                    fontWeight: FontWeight.w400,
                    color: Flavors.colorInfo.homeTabSelected),
                unselectedLabelStyle: TextStyle(
                    fontSize: 10.0.sp,
                    fontWeight: FontWeight.w400,
                    color: Flavors.colorInfo.homeTabUnSelected),
                items: <BottomNavigationBarItem>[
                  _bottomBarTitlesTabBar(Icons.home_outlined, Icons.home, 0),
                  _bottomBarTitlesTabBar(Icons.home_repair_service_outlined,
                      Icons.home_repair_service, 1),
                  _bottomBarTitlesTabBar(
                      Icons.near_me_outlined, Icons.near_me, 2),
                ],
                type: BottomNavigationBarType.fixed,
                currentIndex: _tabIndex,
                iconSize: 30.0,
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
