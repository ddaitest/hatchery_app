import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hatchery/business/home/phone_numbers.dart';
import 'package:hatchery/business/home/report_something.dart';
import 'package:hatchery/manager/upgrade_manager.dart';
import 'package:provider/provider.dart';
import 'package:hatchery/manager/service_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:hatchery/common/widget/webview_common.dart';

class ServiceTab extends StatefulWidget {
  @override
  ServiceTabState createState() => ServiceTabState();
}

class ServiceTabState extends State<ServiceTab> {
//  @override
//  bool get wantKeepAlive => true;
  ScrollController _scrollController = ScrollController(); //listview的控制器
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    UpgradeManager().isShowUpgradeCard(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ServiceManager(),
      child: _servicePage(context),
    );
  }

  Future<Null> refreshData() async {
    await Future.delayed(Duration(seconds: 1), () {
      return ServiceManager();
    });
  }

  _servicePage(BuildContext context) {
    return Consumer<ServiceManager>(
        builder: (context, manager, child) => _pageTopView(manager));
  }

  _pageTopView(manager) {
    return Column(
      children: <Widget>[
        Container(
          height: 80,
          decoration: BoxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _topButtons(CommunityMaterialIcons.account_card_details,
                  Colors.black, manager.ServiceTopMap["0"], Colors.black),
              _topButtons(Icons.live_help, Colors.black,
                  manager.ServiceTopMap["1"], Colors.black),
              _topButtons(Icons.android, Colors.black,
                  manager.ServiceTopMap["2"], Colors.black),
              _topButtons(Icons.language, Colors.black,
                  manager.ServiceTopMap["3"], Colors.black),
            ],
          ),
        ),
        Container(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              MaterialButton(
                onPressed: () {
//                  showUpdateCard(context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.language,
                      size: 35,
                      color: Colors.black,
                    ),
                    Text(
                      manager.ServiceTopMap["6"],
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.language,
                      size: 35,
                      color: Colors.black,
                    ),
                    Text(
                      manager.ServiceTopMap["6"],
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PhoneNumbersPage()),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.language,
                      size: 35,
                      color: Colors.black,
                    ),
                    Text(
                      manager.ServiceTopMap["7"],
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReportSomethingPage()),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.language,
                      size: 35,
                      color: Colors.black,
                    ),
                    Text(
                      manager.ServiceTopMap["7"],
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 10,
          color: Color.fromARGB(255, 234, 233, 234),
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
        _getListViewContainer(),
      ],
    );
  }

  _getListViewContainer() {
    return Consumer<ServiceManager>(builder: (glvc, manager, glv) {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          print('滑动到了最底部');
//          ServiceManager();
        }
      });
      if (manager.total == 0) {
        ///loading
        return CupertinoActivityIndicator();
      } else {
        return Expanded(
          child: RefreshIndicator(
            onRefresh: refreshData,
            displacement: 20,
            child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: manager.total,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _getItemContainerView(
                          glvc, manager.subjectLists[index], manager),

                      ///下面的灰色分割线
                      Divider(
                        height: 2,
                        color: Colors.grey[400],
                      ),
                    ],
                  );
                }),
          ),
        );
      }
    });
  }

  Widget title(String text) => Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Text(
          text,
          style: Theme.of(context).textTheme.title,
          textAlign: TextAlign.center,
        ),
      );

  @override
  void dispose() {
    super.dispose();
  }
}

_getItemContainerView(BuildContext gicv, var subject, manager) {
  var imgUrl = subject.image;
  return Consumer<ServiceManager>(
      builder: (glvc, manager, glv) => GestureDetector(
            onTap: () {
              if (subject.url != null) {
                Navigator.push(
                  gicv,
                  MaterialPageRoute(
                      builder: (context) => WebViewPage(subject.url, null)),
                );
              }
            },
            child: Container(
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  _getImage(imgUrl),
                  Container(
                      child: _getInfoView(subject),
                      width: MediaQuery.of(gicv).size.width - 116),
                ],
              ),
            ),
          ));
}

_getInfoView(var subject) {
  return Container(
    height: 90,
    alignment: Alignment.topLeft,
    child: Column(
      children: <Widget>[
        _getTitleView(subject),
      ],
    ),
  );
}

_getTitleView(subject) {
  return Container(
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text(
            subject.title,
            textAlign: TextAlign.left,
            overflow: TextOverflow.visible,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ],
    ),
  );
}

_getImage(var imgUrl) {
  return Container(
    child: CachedNetworkImage(
      height: 90,
      width: 90,
      imageUrl: imgUrl,
      fit: BoxFit.fill,
    ),
    margin: EdgeInsets.only(left: 8, top: 3, right: 8, bottom: 3),
    width: 100.0,
  );
}

_topButtons(iconName, iconColor, String name, nameColor) {
  return Consumer<ServiceManager>(
      builder: (context, manager, child) => MaterialButton(
            onPressed: null,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  iconName,
                  size: 35,
                  color: iconColor,
                ),
                Text(
                  name,
                  style: TextStyle(color: nameColor, fontSize: 12),
                ),
              ],
            ),
          ));
}
