import 'package:flutter/material.dart';
import 'package:hatchery/common/theme.dart';
import 'package:hatchery/common/widget/page_title.dart';
import 'package:hatchery/test/test_page.dart';

import '../../configs.dart';
import 'first_page.dart';

class HomePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController controller;
  int page = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    controller.addListener(() {
      print("DDAI= controller.index=${controller.index}");
      setState(() {
        page = controller.index;
      });
    });
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return getMyScaffold(
      APP_TITLE,
      key: _scaffoldKey,
      titleAlign: TextAlign.center,
      leading: Container(),
      body: _getBody(),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        notchMargin: 4.0,
        child: TabBar(
          tabs: <Tab>[
            Tab(child: Text("首页", style: fontPhone)),
            Tab(child: Text("周边", style: fontPhone)),
            Tab(child: Text("服务", style: fontPhone)),
          ],
          controller: controller,
        ),
      ),
    );
  }

  _getBody() {
    return TabBarView(
      children: <Widget>[
        TestPage(info: "TestPage"),
        SecondPage(),
        ThirdPage(),
      ],
      controller: controller,
    );
  }
}
