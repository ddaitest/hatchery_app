import 'package:flutter/material.dart';
import 'package:hatchery/business/home/home_tab.dart';
import 'package:hatchery/business/nearby/nearby_tab.dart';
import 'package:hatchery/business/service/service_tab.dart';
import 'package:hatchery/common/AppContext.dart';
import 'package:hatchery/common/widget/app_bar.dart';
import 'package:hatchery/common/utils.dart';
import 'package:flutter/services.dart';
import 'package:hatchery/common/tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:hatchery/manager/home_manager.dart';
import 'package:hatchery/manager/nearby_manager.dart';
import 'package:package_info/package_info.dart';
import 'package:hatchery/test/TestSilver.dart';
import 'package:hatchery/test/test_provider.dart';
import 'package:provider/provider.dart';

class MainTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainTabHandler(
      x: 0,
      child: MainTab2(),
    );
  }
}

class MainTab2 extends StatefulWidget {
  @override
  MainTabState createState() => MainTabState();
}

class MainTabState extends State<MainTab2> with SingleTickerProviderStateMixin {
  bool nextKickBackExitApp = false;
  var bottomBarTitles = Flavors.stringsInfo.main_tab_title;
  List<Widget> _tabBodies = [HomeTab(), ServiceTab(), NearbyTab()];

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: _tabBodies.length);
    Future.delayed(Duration(milliseconds: 200), () {
      MainTabHandler.of(context).setGotoFun((page) {
        if (_tabController.index != page) {
          _tabController.animateTo(page);
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    MainTabHandler.of(context).setGotoFun(null);
    super.dispose();
  }

  void handleClick(String value) {
    switch (value) {
      case '关于物业':
        PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
          String version = packageInfo.version;
          String buildNumber = packageInfo.buildNumber;
          showToast(version + '\n' + buildNumber);
        });
        break;
      case '商务合作':
      // todo
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar:
        AppBarFactory.getMain(Flavors.stringsInfo.community_name, actions: [
          PopupMenuButton<String>(
            onSelected: handleClick,
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return {'关于物业', '商务合作'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ]),
        body: SafeArea(
          child: TabBarView(
            controller: _tabController,
            children: _tabBodies,
          ),
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: TabBar(
          controller: _tabController,
          labelColor: Colors.black87,
          tabs: bottomBarTitles.entries
          // .map((e) => Tab(text: e.key, icon: Icon(e.value)))
              .map((e) => HomeTabView(e.value, e.key))
              .toList(),
        ),
      ),
    );
  }

  // BottomNavigationBarItem _bottomBarTitlesTabBar(
  //     IconData unSelectIconName, IconData selectedIconName, int barTitleIndex) {
  //   return BottomNavigationBarItem(
  //     icon: Icon(unSelectIconName, size: 30.0),
  //     activeIcon: Icon(selectedIconName, size: 30.0),
  //     label: bottomBarTitles[barTitleIndex],
  //   );
  // }

  Future<bool> _onWillPop() async {
    if (nextKickBackExitApp) {
      // exitApp();
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
}

class HomeTabView extends StatelessWidget {
  final IconData? icon;
  final String? label;

  HomeTabView(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 30.0),
            Text(
              label ?? "",
              style: Flavors.textStyles.tabBarTextUnSelected,
            )
          ],
        ),
        widthFactor: 1.0,
      ),
    );
  }
}

typedef void Goto(int page);

class MainTabHandler extends InheritedWidget {
  const MainTabHandler({
    Key? key,
    required this.x,
    required Widget child,
  }) : super(key: key, child: child);

  final int x;

  static MainTabHandler of(BuildContext context) {
    final MainTabHandler? result =
    context.dependOnInheritedWidgetOfExactType<MainTabHandler>();
    assert(result != null, 'No FrogColor found in context');
    return result!;
  }

  static int tt = 0;

  static Goto? goto;

  @override
  bool updateShouldNotify(MainTabHandler old) => x != old.x;

  ///跳转到置顶 Home 的 tab 页。
  gotoTab(int tab) {
    if (tab >= 0 && tab < 3) {
      if (goto != null) {
        goto!(tab);
      }
    }
  }

  /// Home 页跳转的回调，应该在initState 时候添加，depose 时候移除
  setGotoFun(Goto? fun) {
    goto = fun;
  }
}
