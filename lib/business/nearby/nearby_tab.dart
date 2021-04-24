import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/common/AppContext.dart';
import 'package:hatchery/common/log.dart';
import 'package:hatchery/common/widget/article_item.dart';
import 'package:hatchery/common/widget/list_wrapper.dart';
import 'package:hatchery/common/widget/banner_common_view.dart';
import 'package:hatchery/manager/nearby_manager.dart';
import 'package:provider/provider.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
    App.manager<NearbyManager>().init();
    super.initState();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        color: Color(0xFFF7F7F7),
        child: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: true,
          header: getSimpleHeader(),
          footer: getSimpleFooter(),
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView(
            children: [_topPart(), _listPart()],
          ),
        ));
  }

  void _onRefresh() async {
    App.manager<NearbyManager>()
        .refresh()
        .then((value) => value.handle(_refreshController));
  }

  void _onLoading() async {
    App.manager<NearbyManager>()
        .loadMore()
        .then((value) => value.handle(_refreshController));
  }

  Widget _topPart() {
    return Selector<NearbyManager, List<BannerInfo>>(
      builder: (BuildContext context, List<BannerInfo> value, Widget? child) {
        Log.log("_topPart 重绘了。。。。", color: LColor.RED);
        return Container(
            width: Flavors.sizesInfo.screenWidth,
            padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
            ),
            child: BannerCommonView(value));
      },
      selector: (BuildContext context, NearbyManager homeManager) {
        return homeManager.banners;
      },
      shouldRebuild: (pre, next) {
        Log.log("pre =${pre.hashCode}; length=${pre.length}",
            color: LColor.RED);
        Log.log("next =${next.hashCode}; length=${next.length}",
            color: LColor.RED);
        Log.log(
            "shouldRebuild =${((pre != next) || (pre.length != next.length))}",
            color: LColor.RED);
        return ((pre != next) || (pre.length != next.length));
      },
    );
  }

  Widget _listPart() {
    return Container(
        padding: const EdgeInsets.all(7.0),
        child: Selector<NearbyManager, List<Article>>(
          builder: (context, value, child) {
            Log.log("_listPart 重绘了。。。。", color: LColor.YELLOW);
            return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  color: Color(0xFFFFFFFF),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: value.map((e) => ArticleItem(e)).toList(),
                ));
          },
          selector: (BuildContext context, NearbyManager manager) {
            return manager.articles;
          },
          shouldRebuild: (pre, next) {
            Log.log("pre =${pre.hashCode}; length=${pre.length}",
                color: LColor.YELLOW);
            Log.log("next =${next.hashCode}; length=${next.length}",
                color: LColor.YELLOW);
            Log.log(
                "shouldRebuild =${((pre != next) || (pre.length != next.length))}",
                color: LColor.YELLOW);
            return ((pre != next) || (pre.length != next.length));
          },
        ));
  }
}
