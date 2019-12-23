import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hatchery/manager/nearby_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hatchery/common/widget/webview_common.dart';

class NearbyTab extends StatefulWidget {
  @override
  NearbyTabState createState() => NearbyTabState();
}

class NearbyTabState extends State<NearbyTab> {
  var subjects = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => NearbyManager(),
      child: _bodyContainer(context),
    );
  }

  Future<Null> RefreshData() async {
    await Future.delayed(Duration(seconds: 1), () {
      return NearbyManager();
    });
  }

  _bodyContainer(BuildContext context) {
    return RefreshIndicator(
        onRefresh: RefreshData,
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
      if (manager.total == 0) {
        ///loading
        return CupertinoActivityIndicator();
      } else {
        return Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: manager.total,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      glvc,
                      MaterialPageRoute(
                          builder: (context) => WebViewPage(
                              manager.subjectLists[index].gotoUrl, null)),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      getItemContainerView(
                          glvc, manager.subjectLists[index], manager),

                      ///下面的灰色分割线
                      Divider(
                        height: 2,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                );
              }),
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}

getItemContainerView(BuildContext gicv, var subject, manager) {
  var imgUrl = subject.img;
  return Consumer<NearbyManager>(
    builder: (glvc, manager, glv) => Container(
//              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Container(
              child: getInfoView(subject),
              width: MediaQuery.of(gicv).size.width - 116),
          getImage(imgUrl),
        ],
      ),
    ),
  );
}

getInfoView(var subject) {
  return Container(
    height: 90,
    alignment: Alignment.topRight,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[getTitleView(subject), getScoreView(subject)],
    ),
  );
}

getScoreView(var subject) {
  return Container(
    alignment: Alignment.bottomLeft,
    child: Text("  评分：" + subject.score),
  );
}

getTitleView(subject) {
  return Container(
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text(
            subject.title,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ],
    ),
  );
}

getImage(var imgUrl) {
  return Container(
    child: CachedNetworkImage(
      height: 58,
      width: 31,
      imageUrl: imgUrl,
      fit: BoxFit.cover,
    ),
    margin: EdgeInsets.only(left: 8, top: 3, right: 8, bottom: 3),
    width: 100.0,
  );
}
