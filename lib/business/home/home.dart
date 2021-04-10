import 'dart:collection';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/common/widget/article_item.dart';
import 'package:hatchery/common/widget/backgourds.dart';
import 'package:hatchery/common/widget/post_item.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:hatchery/manager/home_manager.dart';
import 'package:hatchery/common/exts.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        // shrinkWrap: true,
        children: [
          _bannerView(context),
          _moreServiceView(),
          _noticeView(),
          _articlesView(context),
        ],
      ),
    );
  }

  /// View: Banner
  Widget _bannerView(BuildContext context) {
    return Selector<HomeManager, UnmodifiableListView<BannerInfo>>(
      builder: (BuildContext context, UnmodifiableListView<BannerInfo> value,
          Widget? child) {
        print("DEBUG=> _bannerView 重绘了。。。。。");
        return Container(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20.0),
          width: 300.0.w,
          height: 120.0.h,
          child: Swiper(
            autoplay: true,
            itemBuilder: (BuildContext context, int index) {
              ImageProvider imageProvider;
              String imageURL = value[index].image;
              imageProvider = CachedNetworkImageProvider(imageURL);
              return ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image(image: imageProvider, fit: BoxFit.fitWidth),
              );
            },
            itemHeight: 120.0.h,
            itemCount: value.length,
            viewportFraction: 1,
            scale: 0.9,
            pagination: SwiperPagination(),
//        control: SwiperControl(),
            onTap: (index) {
              // manager.clickBanner(index);
            },
          ),
        );
      },
      selector: (BuildContext context, HomeManager homeManager) {
        return homeManager.bannerList;
      },
      shouldRebuild: (pre, next) => pre != next,
    );
  }

  Widget _moreServiceView() {
    print("DEBUG=> _moreServiceView 重绘了。。。。。");
    return Container(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _moreServiceItem('images/image1.png', '问题反馈'),
          _moreServiceItem('images/image2.png', '报事报修'),
          _moreServiceItem('images/image3.png', '联系物业'),
          _moreServiceItem('images/image4.png', '全部服务'),
        ],
      ),
    );
  }

  Widget _moreServiceItem(String imagePath, String text) {
    return Container(
      // height: 50.0.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            imagePath,
            height: 30.0.h,
            width: 30.0.w,
          ),
          Container(height: 10.0.h),
          Text(text,
              style: TextStyle(
                  fontSize: 13.sp, color: Color.fromRGBO(51, 51, 51, 1)))
        ],
      ),
    );
  }

  Widget _noticeView() {
    return Selector(
      builder: (BuildContext context, UnmodifiableListView<Notice> value,
          Widget? child) {
        print("DEBUG=> _noticeView 重绘了。。。。。");
        return Container(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '物业公告',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: Color.fromRGBO(51, 51, 51, 1)),
                      ),
                      value.length > 4
                          ? Text(
                              '更多 >',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color.fromRGBO(155, 155, 155, 1)),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Container(height: 15.0),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.length,
                  itemBuilder: (BuildContext context, int index) =>
                      _noticeTitle('${value[index].title}'),
                ),
              ],
            ));
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
        child: Text(text,
            style: TextStyle(
                fontSize: 14.sp, color: Color.fromRGBO(51, 51, 51, 1))));
  }

  Widget _articlesView(BuildContext context) {
    return Selector<HomeManager, UnmodifiableListView<Article>>(
      builder: (BuildContext context, UnmodifiableListView<Article> value,
          Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '便民信息',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: Color.fromRGBO(51, 51, 51, 1)),
                  ),
                  value.isNotEmpty
                      ? Text(
                          '更多 >',
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Color.fromRGBO(155, 155, 155, 1)),
                        )
                      : Container(),
                ],
              ),
            ),
            Container(height: 10.0.h),
            Container(
              // padding: const EdgeInsets.only(left: 0.0, right: 0.0),
              child: ListView.builder(
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
            ),
          ],
        );
      },
      selector: (BuildContext context, HomeManager homeManager) {
        return homeManager.articlesList;
      },
      shouldRebuild: (pre, next) => pre != next,
    );
  }
}
