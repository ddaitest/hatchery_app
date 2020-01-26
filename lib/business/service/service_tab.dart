import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hatchery/manager/upgrade_manager.dart';
import 'package:provider/provider.dart';
import 'package:hatchery/manager/service_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hatchery/common/widget/webview_common.dart';

class ServiceTab extends StatefulWidget {
  @override
  ServiceTabState createState() => ServiceTabState();
}

class ServiceTabState extends State<ServiceTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<Widget> topShow = [];

  @override
  void initState() {
    super.initState();
    UpgradeManager().isShowUpgradeCard(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ServiceManager(),
      child: _bodyContainer(),
    );
  }

  Future<Null> _refreshData() async {
    await Future.delayed(Duration(seconds: 1), () {
      topShow.clear();
      return ServiceManager();
    });
  }

  _bodyContainer() {
    return RefreshIndicator(
        onRefresh: _refreshData,
        displacement: 20,
        child: Container(
          child: _getListViewContainer(),
        ));
  }

  _pageTopView() {
    topShow.clear();
    return Selector<ServiceManager, List>(
        builder: (context, topList, Widget child) {
          print('######${topList.length}');
          if (topList.length <= 4) {
            topList.forEach(
                (item) => topShow.add(_topButtons(item.icon, item.title)));
            return Container(
                height: 60,
                decoration: BoxDecoration(),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: topShow));
          } else {
            topList.forEach(
                (item) => topShow.add(_topButtons(item.icon, item.title)));
            return Column(children: <Widget>[
              Container(
                  height: 60,
                  decoration: BoxDecoration(),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: topShow.sublist(0, 4))),
              Container(height: 10),
              Container(
                  height: 60,
                  decoration: BoxDecoration(),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: topShow.sublist(4, topList.length)))
            ]);
          }
        },
        selector: (BuildContext context, ServiceManager manager) =>
            manager.topList);
  }

  _getListViewContainer() {
    return Consumer<ServiceManager>(builder: (glvc, manager, glv) {
      manager.scrollController.addListener(() {
        if (manager.scrollController.position.pixels ==
            manager.scrollController.position.maxScrollExtent) {
          manager.getMore();
        }
      });
      if (manager.total == 0) {
        ///loading
        return CupertinoActivityIndicator();
      } else {
        return ListView.separated(
          controller: manager.scrollController,
          shrinkWrap: true,
          itemCount: manager.total + 1,
          // ignore: missing_return
          itemBuilder: (BuildContext context, int index) {
            if (index < manager.total) {
              if (index == 0) {
                return _pageTopView();
              } else {
                return _getItemContainerView(
                    glvc, manager.subjectLists[index], manager);
              }
            } else if (manager.parsed['result'].length == 0) {
              return _noMoreWidget();
            } else {
              return _getMoreWidget();
            }
          },
          separatorBuilder: (BuildContext context, int index) => Divider(),
        );
      }
    });
  }

  Widget _getMoreWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '加载中...  ',
              style: TextStyle(fontSize: 16.0),
            ),
            CircularProgressIndicator(
              strokeWidth: 1.0,
            )
          ],
        ),
      ),
    );
  }

  Widget _noMoreWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '已经是最后一条了',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
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

_topButtons(iconUrl, String name) {
  return GestureDetector(
    onTap: null,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CachedNetworkImage(
          height: 36.6,
          width: 32,
          imageUrl: iconUrl,
          fit: BoxFit.fill,
        ),
        Text(
          name,
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
      ],
    ),
  );
}
