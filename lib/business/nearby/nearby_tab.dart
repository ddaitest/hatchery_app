import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hatchery/business/home/phone_numbers.dart';
import 'package:hatchery/business/home/report_something.dart';
import 'package:provider/provider.dart';
import 'package:hatchery/manager/nearby_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:hatchery/common/widget/webview_common.dart';

class NearbyTab extends StatefulWidget {
  @override
  NearbyTabState createState() => NearbyTabState();
}

class NearbyTabState extends State<NearbyTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NearbyManager(),
      child: _nearbyPage(context),
    );
  }

  Future<Null> _refreshData() async {
    await Future.delayed(Duration(seconds: 1), () {
      return NearbyManager();
    });
  }

  _nearbyPage(BuildContext context) {
    return Consumer<NearbyManager>(
        builder: (context, manager, child) => _bodyContainer(context));
  }

  _bodyContainer(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _refreshData,
        displacement: 20,
        child: Container(
          color: Colors.white,
          child: Column(children: [
            _bannerContainer(context),
            Container(
              height: 10,
              color: Colors.white,
            ),
            _getListViewContainer(),
          ]),
        ));
  }

  _bannerContainer(BuildContext context) {
    return Consumer<NearbyManager>(
        builder: (context, manager, child) => Container(
              margin: EdgeInsets.only(top: 10),
              height: 120,
              child: Swiper(
                autoplay: true,
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image(
                      image:
                          CachedNetworkImageProvider(manager.bannerList[index]),
                      fit: BoxFit.fitWidth,
                    ),
                  );
                },
                itemHeight: 120,
                itemCount: manager.bannerTotal,
                viewportFraction: 0.8,
                scale: 0.9,
                pagination: SwiperPagination(),
                onTap: (index) {
                  try {
//            launchcaller(infos[index].action);
                  } catch (id) {}
                },
              ),
            ));
  }

  _getListViewContainer() {
    return Consumer<NearbyManager>(builder: (glvc, manager, glv) {
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
        return Expanded(
          child: ListView.builder(
              controller: manager.scrollController,
              shrinkWrap: true,
              itemCount: manager.total + 1,
              // ignore: missing_return
              itemBuilder: (BuildContext context, int index) {
                if (index < manager.total) {
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
                } else if (manager.parsed['result'].length == 0) {
                  return _noMoreWidget();
                } else {
                  return _getMoreWidget();
                }
              }),
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
  return Consumer<NearbyManager>(
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
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: _getInfoView(subject),
              width: MediaQuery.of(gicv).size.width - 116,
            ),
            _getImage(imgUrl),
          ],
        ),
      ),
    ),
  );
}

_getInfoView(var subject) {
  return Container(
    height: 90,
    alignment: Alignment.topRight,
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
