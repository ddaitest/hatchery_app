import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/common/AppContext.dart';
import 'package:hatchery/common/widget/ServiceItem.dart';
import 'package:hatchery/common/widget/article_item.dart';
import 'package:hatchery/common/widget/backgourds.dart';
import 'package:hatchery/common/widget/loading_view.dart';
import 'package:hatchery/common/widget/post_item.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:hatchery/manager/home_manager.dart';
import 'package:hatchery/configs.dart';
import 'package:hatchery/common/exts.dart';
import 'package:hatchery/manager/service_manager.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF7F7F7),
      child: ListView(
        // shrinkWrap: true,
        children: [
          _topContainerMain(context),
          _noticeContainerMain(),
          _articlesContainerMain(context),
        ],
      ),
    );
  }

  /// 顶部banner & service View
  Widget _topContainerMain(context) {
    HomeManager _homeManager = HomeManager();
    Future.delayed(Duration(seconds: Flavors.timeConfig.POP_AD_WAIT_TIME),
        () async {
      if (_homeManager.popAdList.isNotEmpty) _popAdView(context, _homeManager);
    });
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
    HomeManager _homeManager = HomeManager();
    return Selector<HomeManager, UnmodifiableListView<BannerInfo>>(
      builder: (BuildContext context, UnmodifiableListView<BannerInfo> value,
          Widget? child) {
        print("DEBUG=> _bannerView 重绘了。。。。。");
        return value.isNotEmpty
            ? Container(
                padding: const EdgeInsets.only(left: 7.0, right: 7.0),
                height: 92.0.h,
                child: Swiper(
                  autoplay: value.length != 1 ? true : false,
                  physics: value.length != 1
                      ? const AlwaysScrollableScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      child: CachedNetworkImage(
                        // imageUrl:
                        //     'https://img.zcool.cn/community/01d56b5542d8bc0000019ae98da289.jpg@1280w_1l_2o_100sh.png',
                        imageUrl: value[index].image,
                        fit: BoxFit.fitWidth,
                        placeholder: (context, url) => LoadingView(
                            viewHeight: 92.0.h,
                            viewWidth: Flavors.sizesInfo.screenWidth),
                        errorWidget: (context, url, error) => Icon(
                          Icons.image_not_supported_outlined,
                          size: 40.0,
                        ),
                      ),
                    );
                  },
                  itemHeight: 92.0.h,
                  itemCount: value.length,
                  viewportFraction: 1,
                  scale: 0.9,
                  pagination: value.length != 1
                      ? SwiperPagination()
                      : SwiperPagination(builder: SwiperPagination.rect),
                  onTap: (index) {
                    _homeManager.clickBanner(index);
                  },
                ),
              )
            : Container();
      },
      selector: (BuildContext context, HomeManager homeManager) {
        return homeManager.bannerList;
      },
      shouldRebuild: (pre, next) => pre != next,
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
    return Selector(
      builder: (BuildContext context, UnmodifiableListView<Notice> value,
          Widget? child) {
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
                      '物业公告',
                      style: Flavors.textStyles.sortTitle,
                    ),
                    Text(
                      '更多 >',
                      style: Flavors.textStyles.moreText,
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
              Container(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 16.0, bottom: 10.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: value.isEmpty ? 3 : value.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (value.isEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LoadingView(viewHeight: 17.0, viewWidth: 200.0),
                            Container(height: 10.h)
                          ],
                        );
                      } else {
                        // return _noticeTitle('基于屏幕顶部和底部的布局，如弹框，在全面屏上显示会发生位移');
                        return _noticeTitle('${value[index].title}');
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
      shouldRebuild: (pre, next) => pre != next,
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
    return Selector<HomeManager, UnmodifiableListView<Article>>(
      builder: (BuildContext context, UnmodifiableListView<Article> value,
          Widget? child) {
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
                        '便民信息',
                        style: Flavors.textStyles.sortTitle,
                      ),
                      Text(
                        '更多 >',
                        style: Flavors.textStyles.moreText,
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
      shouldRebuild: (pre, next) => pre != next,
    );
  }

  _popAdView(BuildContext context, homeManager) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          homeManager.setPopShowCount();
          return Center(
            child: Container(
              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      homeManager.clickPopAd(homeManager.popAdList[0]);
                    },
                    child: CachedNetworkImage(
                      imageUrl: homeManager.popAdList[0].image,
                      fit: BoxFit.fitWidth,
                      errorWidget: (context, url, error) =>
                          Icon(Icons.image_not_supported_outlined),
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
        });
  }
}
