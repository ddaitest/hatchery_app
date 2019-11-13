import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hatchery/manager/beans.dart';

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
    var views = <Widget>[];
    //添加搜索
//    var searchCondition = model.getSearchCondition(pageType);
//    print("getBodyView searchCondition=$searchCondition");
//    if (searchCondition != null) {
//      views.add(getSearchView(
//        searchCondition,
//            () {
//          _gotoSearch();
//        },
//            () {
//          model.updateSearchCondition(pageType, null);
//        },
//      ));
//    }
    //添加列表
    views.add(Expanded(child: _getScrollBody()));

    return Container(
      child: Column(children: views),
      color: Colors.white,
    );
  }

  /// View: 列表。
  _getScrollBody() {
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
//      child: _list(),
      child: _scrollView(),
    );
  }

  Widget _scrollView() {
    final views = <Widget>[];

    //添加banner
    List<BannerInfo> info = List<BannerInfo>();
    info.add(BannerInfo(
        id: "id",
        image: "https://v1.vuepress.vuejs.org/hero.png",
        action: "http://baidu.com"));
    info.add(BannerInfo(
        id: "id",
        image: "https://v1.vuepress.vuejs.org/hero.png",
        action: "http://baidu.com"));
    info.add(BannerInfo(
        id: "id",
        image: "https://v1.vuepress.vuejs.org/hero.png",
        action: "http://baidu.com"));
    if (info != null && info.length > 0) {
      views.add(
        SliverPersistentHeader(
          delegate: _SliverAppBarDelegate(_getBannerView(info), 120, 120),
          floating: false,
          pinned: false,
        ),
      );
    }

    views.add(_list());
    return CustomScrollView(
      slivers: views,
    );
  }

  Widget _list() {
//    List<Article> data = model.getListData(pageType);
//    final enablePullUp = model.getHasMore(pageType);
    final enablePullUp = false;
    List<Article> data = List<Article>();
    data.add(Article(title: "AAA"));
    data.add(Article(title: "bbb"));
    data.add(Article(title: "ccc"));
    data.add(Article(title: "ddd"));
    data.add(Article(title: "eee"));
    var size = 10;
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) => index == data.length
          ? _getLoadMore()
          : ListTile(
              title: Text(data[index].title),
            ),
      childCount: enablePullUp ? data.length + 1 : data.length,
    ));
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
              image: new CachedNetworkImageProvider(infos[index].image),
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

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this.subView, this.minHeight, this.maxHeight);

  final Widget subView;
  final double minHeight;
  final double maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: subView,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
