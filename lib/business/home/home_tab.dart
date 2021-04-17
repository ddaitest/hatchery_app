import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/business/main_tab.dart';
import 'package:hatchery/common/AppContext.dart';
import 'package:hatchery/common/widget/ServiceItem.dart';
import 'package:hatchery/common/widget/article_item.dart';
import 'package:hatchery/common/widget/banner_common_view.dart';
import 'package:hatchery/common/widget/list_wrapper.dart';
import 'package:hatchery/common/widget/loading_view.dart';
import 'package:hatchery/config.dart';
import 'package:hatchery/routers.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:hatchery/manager/home_manager.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeTab extends StatefulWidget {
  @override
  HomeTabState createState() => HomeTabState();
}

class HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  var _refreshController = RefreshController(initialRefresh: true);

  @override
  void initState() {
    App.manager<HomeManager>().checkPopAd().then((ad) {
      if (ad != null) {
        _popAdView(context, ad);
      }
    });
    // Future.delayed(Duration(seconds: TimeConfig.POP_AD_WAIT_TIME), () async {
    //   if (_homeManager.popAdList.isNotEmpty) {
    //     _popAdView(context, _homeManager);
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        color: Color(0xFFF7F7F7),
        child: SmartRefresher(
          controller: _refreshController,
          header: getSimpleHeader(),
          onRefresh: _onRefresh,
          child: ListView(
            // shrinkWrap: true,
            children: [
              _topContainerMain(context),
              _noticeContainerMain(),
              _articlesContainerMain(context),
            ],
          ),
        ));
  }

  /// 顶部banner & service View
  Widget _topContainerMain(context) {
    return Container(
      width: Flavors.sizesInfo.screenWidth,
      height: 175.0.h,
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Container(
        child: Column(
          children: [
            _bannerView(context),
            _moreServiceView(),
          ],
        ),
      ),
    );
  }

  Widget _noticeContainerMain() {
    return Container(
      padding:
          const EdgeInsets.only(left: 7.0, right: 7.0, top: 12.0, bottom: 12.0),
      child: _noticeView(),
    );
  }

  Widget _articlesContainerMain(context) {
    return Container(
      padding: const EdgeInsets.only(left: 7.0, right: 7.0, bottom: 12.0),
      child: _articlesView(context),
    );
  }

  /// View: Banner
  Widget _bannerView(BuildContext context) {
    return Selector<HomeManager, List<BannerInfo>>(
      builder: (BuildContext context, List<BannerInfo> value, Widget? child) {
        print("DEBUG=> _bannerView 重绘了。。。。。");
        return BannerCommonView(value);
      },
      selector: (BuildContext context, HomeManager homeManager) {
        return homeManager.bannerList;
      },
      shouldRebuild: (pre, next) =>
          ((pre != next) || (pre.length != next.length)),
    );
  }

  Widget _moreServiceView() {
    print("DEBUG=> _moreServiceView 重绘了。。。。。");
    HomeManager manager = App.manager<HomeManager>();
    return Container(
      padding: const EdgeInsets.only(left: 14.0, right: 14.0, top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: manager.services
            .map((e) =>
                ServiceItem(e.image, e.name, () => manager.clickService(e)))
            .toList(),
      ),
    );
  }

  Widget _noticeView() {
    return Selector<HomeManager, List<Notice>>(
      builder: (BuildContext context, List<Notice> value, Widget? child) {
        print("DEBUG=> _noticeView 重绘了。。。。。");
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            color: Color(0xFFFFFFFF),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${Flavors.stringsInfo.post_title}',
                      style: Flavors.textStyles.sortTitle,
                    ),
                    value.length > 4
                        ? Text(
                            '更多 >',
                            style: Flavors.textStyles.moreText,
                          )
                        : Container(),
                  ],
                ),
              ),
              Divider(
                indent: 14.0,
                endIndent: 14.0,
                thickness: 1.0.h,
                height: 1.0.h,
                color: Color(0xFFF4F4F4),
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 16.0, bottom: 10.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: value.isEmpty
                        ? 4
                        : value.length > 4
                            ? 4
                            : value.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (value.isEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LoadingView(
                                viewHeight: 14.0,
                                viewWidth: Flavors.sizesInfo.screenWidth),
                            Container(height: 10.h)
                          ],
                        );
                      } else {
                        // return _noticeTitle('基于屏幕顶部和底部的布局，如弹框，在全面屏上显示会发生位移');
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () =>
                              Routers.navWebView(value[index].redirectUrl),
                          child: _noticeTitle('${value[index].title}'),
                        );
                      }
                    }),
              ),
            ],
          ),
        );
      },
      selector: (BuildContext context, HomeManager homeManager) {
        return homeManager.noticesList;
      },
      shouldRebuild: (pre, next) =>
          ((pre != next) || (pre.length != next.length)),
    );
  }

  Widget _noticeTitle(String text) {
    return Container(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Text('$text',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Flavors.textStyles.noticeText));
  }

  Widget _articlesView(BuildContext context) {
    return Selector<HomeManager, List<Article>>(
      builder: (BuildContext context, List<Article> value, Widget? child) {
        return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
              color: Color(0xFFFFFFFF),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${Flavors.stringsInfo.articles_title}',
                        style: Flavors.textStyles.sortTitle,
                      ),
                      GestureDetector(
                        // behavior: HitTestBehavior.opaque,
                        onTap: () => MainTabHandler.of(context).gotoTab(2),
                        child: Text(
                          '更多 >',
                          style: Flavors.textStyles.moreText,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  indent: 14.0,
                  endIndent: 14.0,
                  thickness: 1.0.h,
                  height: 1.0.h,
                  color: Color(0xFFF4F4F4),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.isEmpty ? 5 : value.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (value.isEmpty) {
                      return ArticleItemLoading();
                    } else {
                      return ArticleItem(value[index]);
                    }
                  },
                ),
              ],
            ));
      },
      selector: (BuildContext context, HomeManager homeManager) {
        return homeManager.articlesList;
      },
      shouldRebuild: (pre, next) =>
          ((pre != next) || (pre.length != next.length)),
    );
  }

  _popAdView(BuildContext context, Advertising advertising) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // homeManager.setPopShowCount();
          return CachedNetworkImage(
            imageUrl: advertising.image,
            imageBuilder: (context, imageProvider) {
              return Center(
                child: Container(
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          App.manager<HomeManager>().clickPopAd(advertising);
                        },
                        child: Image(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(height: 20.0.h),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.cancel_outlined,
                            size: 40.0, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ),
              );
            },
            fit: BoxFit.fitWidth,
            errorWidget: (context, url, error) =>
                Icon(Icons.image_not_supported_outlined, size: 40.0),
          );
        });
  }

  void _onRefresh() async {
    App.manager<HomeManager>()
        .refresh()
        .then((value) => value.handle(_refreshController));
  }
}
