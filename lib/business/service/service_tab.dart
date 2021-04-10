import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/common/AppContext.dart';
import 'package:hatchery/common/widget/ServiceItem.dart';
import 'package:provider/provider.dart';
import 'package:hatchery/manager/service_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hatchery/common/widget/webview_common.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatchery/common/exts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ServiceTab extends StatelessWidget {
//   @override
//   ServiceTabState createState() => ServiceTabState();
// }
//
// class ServiceTabState extends State<ServiceTab>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   bool get wantKeepAlive => true;

  // @override
  // void initState() {
  //   super.initState();
  // }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("pull up load");
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("Load Failed!Click retry!");
          } else if (mode == LoadStatus.canLoading) {
            body = Text("release to load more");
          } else {
            body = Text("No more Data");
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView(
        children: [
          _topPart(context),
          _item(1),
          _item(2),
          _item(3),
          _item(4),
          _item(5),
          _item(6),
          _item(7),
          _item(8),
          _item(9),
          _item(10),
        ],
      ),
    );
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // _refreshController.loadComplete();
    _refreshController.loadNoData();
  }

  Widget _topPart(BuildContext context) {
    return Selector<ServiceManager, List<ServiceInfo>>(
      builder: (context, value, child) {
        return _computeTopServiceView(value);
      },
      selector: (BuildContext context, ServiceManager manager) {
        return manager.services;
      },
      shouldRebuild: (pre, next) =>
          ((pre != next) || (pre.length != next.length)),
    );
  }

  Widget _computeTopServiceView(List<ServiceInfo> data) {
    var views = <Widget>[];
    //generator first line.
    if (data.length > 3) {
      views.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: data
            .sublist(0, 4)
            .map((e) => ServiceItem('images/image1.png', e.name))
            .toList(),
      ));
    }
    //generator second line.
    if (data.length > 4) {
      views.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: data
            .sublist(4)
            .map((e) => ServiceItem('images/image1.png', e.name))
            .toList(),
      ));
    }
    return Container(
      child: Column(
        children: views,
      ),
    );
  }

  // Widget _otherPart() {
  //   return SliverList(
  //     delegate: SliverChildBuilderDelegate(
  //       (BuildContext context, int index) {
  //         return _item(index);
  //       },
  //       childCount: 13,
  //     ),
  //   );
  // }

  _item(int index) {
    var c = Colors.blue;
    if (index % 4 == 1) {
      c = Colors.blue;
    }
    if (index % 4 == 2) {
      c = Colors.deepPurple;
    }
    if (index % 4 == 3) {
      c = Colors.grey;
    }
    if (index % 4 == 0) {
      c = Colors.amber;
    }
    return Container(
      color: c,
      height: 80.h,
    );
  }

  Future<Null> _refreshData() async {
    await Future.delayed(Duration(seconds: 1), () {
      return ServiceManager();
    });
  }

  // _bodyContainer() {
  //   return Consumer<ServiceManager>(builder: (context, manager, child) {
  //     manager.scrollController.addListener(() {
  //       if (manager.scrollController.position.pixels ==
  //           manager.scrollController.position.maxScrollExtent) {}
  //     });
  //     manager.topShow.clear();
  //     return RefreshIndicator(
  //         onRefresh: _refreshData,
  //         displacement: 20,
  //         child: _getListViewContainer(manager));
  //   });
  // }

  _topViewContainer(manager) {
    manager.topShow.clear();
    if (manager.topTotal == 0) {
      return Text('#######');
    } else if (manager.topTotal <= 4 && manager.topTotal != 0) {
      print("#######################");
      manager.topList.forEach(
          (item) => manager.topShow.add(_topButtons(item.icon, item.title)));
      return Container(
          height: 60,
          decoration: BoxDecoration(),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: manager.topShow));
    } else {
      manager.topList.forEach(
          (item) => manager.topShow.add(_topButtons(item.icon, item.title)));
      return Column(children: <Widget>[
        Container(
            height: 60,
            decoration: BoxDecoration(),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: manager.topShow.sublist(0, 4))),
        Container(height: 10),
        Container(
            height: 60,
            decoration: BoxDecoration(),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: manager.topShow.sublist(4, manager.topTotal)))
      ]);
    }
  }

  _getListViewContainer(manager) {
    if (manager.total == 0) {
      ///loading
      return SpinKitWave(
        color: Colors.grey,
        type: SpinKitWaveType.center,
        size: 30,
      );
    } else {
      return ListView.separated(
        controller: manager.scrollController,
        shrinkWrap: true,
        itemCount: manager.total + 1,
        // ignore: missing_return
        itemBuilder: (BuildContext context, int index) {
          if (index < manager.total) {
            if (index == 0) {
              return _topViewContainer(manager);
            } else {
              return _getItemContainerView(
                  context, manager.subjectLists[index]);
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

// Widget title(String text) => Container(
//       margin: EdgeInsets.symmetric(vertical: 4),
//       child: Text(
//         text,
//         style: Theme.of(context).textTheme.title,
//         textAlign: TextAlign.center,
//       ),
//     );
//
// @override
// void dispose() {
//   super.dispose();
// }
}

_getItemContainerView(BuildContext gicv, var subject) {
  var imgUrl = subject.image;
  return GestureDetector(
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
  );
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
        Container(
          height: 3,
        ),
        Text(
          name,
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
      ],
    ),
  );
}

_gotoWebPage(BuildContext context, webId) {
  String webUrl = 'http://39.96.16.125:8081/articles/$webId';
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => WebViewPage(webUrl, null)),
  );
}
