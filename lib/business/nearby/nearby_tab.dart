import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/common/AppContext.dart';
import 'package:hatchery/common/widget/article_item.dart';
import 'package:hatchery/common/widget/list_wrapper.dart';
import 'package:hatchery/common/widget/loading_view.dart';
import 'package:hatchery/manager/nearby_manager.dart';
import 'package:provider/provider.dart';
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
    return SmartRefresher(
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
    );
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
        print("DEBUG=> _bannerView 重绘了。。。。。");
        return Container(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20.0),
          width: 300.0.w,
          height: 120.0.h,
          child: Swiper(
            autoplay: true,
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  imageUrl: value[index].image,
                  fit: BoxFit.fitWidth,
                  placeholder: (context, url) =>
                      LoadingView(1, viewHeight: 120.0.h, viewWidth: 300.0.w),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.image_not_supported_outlined),
                ),
              );
            },
            itemHeight: 120.0.h,
            itemCount: value.length,
            viewportFraction: 1,
            scale: 0.9,
            pagination: SwiperPagination(),
            onTap: (index) {
              App.manager<NearbyManager>().clickBanner(value[index]);
            },
          ),
        );
      },
      selector: (BuildContext context, NearbyManager homeManager) {
        return homeManager.banners;
      },
      shouldRebuild: (pre, next) => pre != next,
    );
  }

  Widget _listPart() {
    return Selector<NearbyManager, List<Article>>(
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: value.map((e) => ArticleItem(e)).toList(),
        );
      },
      selector: (BuildContext context, NearbyManager manager) {
        return manager.articles;
      },
      shouldRebuild: (pre, next) =>
          ((pre != next) || (pre.length != next.length)),
    );
  }
}
