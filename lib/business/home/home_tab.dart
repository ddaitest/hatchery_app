import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hatchery/common/widget/article_item.dart';
import 'package:hatchery/manager/beans.dart';
import 'dart:math' as math;

class HomeTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeTabState();
  }
}

class HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  bool refreshing = false;

//  bool loading = false;

  _refreshList(Function done) {
//    model.queryList(pageType, true, done: done);
  }

  _loadMoreList(Function done) {
//    model.queryList(pageType, false, done: done);
  }

  Future _onRefresh() {
    return Future(() {
      if (!refreshing) {
        refreshing = true;
        print("ERROR. _onRefresh");
        _refreshList(() {
          refreshing = false;
        });
      }
    });
  }

  _onLoadMore() {
//    print("INFO. _onLoadMore $loading");
//    if (!loading) {
//      loading = true;
//      print("ERROR. _onLoadMore");
//      _loadMoreList(() {
//        loading = false;
//      });
//    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: getBodyView(context),
    );
  }

  @override
  void initState() {
    super.initState();
    refreshing = false;
//    loading = false;
//    Future.delayed(Duration.zero, () {
//      var x = MainModel.of(context);
//      //加载 list 数据
//      _onRefresh();
//      //加载 banner 数据
//      x.queryBanner(pageType);
//    });
  }

  getBodyView(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: [_getBanner(), Expanded(child: _getList())]),
    );
  }

  _getBanner() {
    List<BannerInfo> info = List<BannerInfo>();
    info.add(BannerInfo(
        id: "id",
        imgUrl: "https://v1.vuepress.vuejs.org/hero.png",
        webUrl: "http://baidu.com"));
    info.add(BannerInfo(
        id: "id",
        imgUrl: "https://v1.vuepress.vuejs.org/hero.png",
        webUrl: "http://baidu.com"));
    info.add(BannerInfo(
        id: "id",
        imgUrl: "https://v1.vuepress.vuejs.org/hero.png",
        webUrl: "http://baidu.com"));
    return _getBannerView(info);
  }

  /// View: 列表。
  _getList() {
    //    var status = model.getPageStatus(pageType);
    //    if (status == PageDataStatus.READY) {
    if (1 == 1) {
      return RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _onRefresh,
//        child: _list(),
        child: _scrollViewWrapper(),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  _scrollViewWrapper() {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          _onLoadMore();
        }
        return false;
      },
      child: _list(),
//      child: _scrollView(),
    );
  }

  Widget _list() {
    final thumbnail =
        "https://upload-images.jianshu.io/upload_images/10392521-682342d2186572c0.jpg-mobile?imageMogr2/auto-orient/strip|imageView2/2/w/750/format/webp";
    final summary =
        "前段时间一直在进行hybrid app的调优工作，主要工作集中在webview的优化。工程实践虽然离不开方法论的指导，但到了具体实施仍然千差万别。webview优化存在典型的加载时间与优化难度负相关的关系。这次调优，我们也分别从纯前端层面以及Xcode/Java层面进行双向优化的工作。相较而言，纯前端优化有更多传统、经典的方法论作为指导，效果更容易获取。而Xcode/Java层，就需要更多的借鉴和自我创新。今天这篇文章，记录下前端，既纯h5层面可以优化的部分思路。";
//    List<Article> data = model.getListData(pageType);
//    final enablePullUp = model.getHasMore(pageType);
    final enablePullUp = false;
    List<Article> data = List<Article>();
    data.add(Article(title: "AAA", thumbnail: thumbnail, summary: summary));
    data.add(Article(title: "bbb", thumbnail: thumbnail, summary: summary));
    data.add(Article(title: "ccc", thumbnail: thumbnail, summary: summary));
    data.add(Article(title: "ddd", thumbnail: thumbnail, summary: summary));
    data.add(Article(title: "eee", thumbnail: thumbnail, summary: summary));
    var size = 10;
    return ListView.separated(
        itemBuilder: (context, index) => ArticleItem(data[index], () {}),
        separatorBuilder: (context, index) => Divider(
              color: Colors.black,
            ),
        itemCount: data.length);
  }

  _getLoadMore() {
    return Container(
        color: Colors.greenAccent,
        child: FlatButton(
          child: Text("Load More"),
          onPressed: _onLoadMore,
        ));
  }

  /// View: Banner
  _getBannerView(List<BannerInfo> infos) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 120,
      child: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: new BorderRadius.circular(8.0),
            child: Image(
              image: new CachedNetworkImageProvider(infos[index].imgUrl),
              fit: BoxFit.fitWidth,
            ),
          );
        },
        itemHeight: 120,
        itemCount: infos.length,
        viewportFraction: 0.8,
        scale: 0.9,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
        onTap: (index) {
          try {
//            launchcaller(infos[index].action);
          } catch (id) {}
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
