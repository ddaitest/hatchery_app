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
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeManager(context),
      child: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    HomeManager _homeManager = Provider.of<HomeManager>(context, listen: false);
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView(
        // shrinkWrap: true,
        children: [
          _bannerView(context),
          _moreServiceView(),
          _noticeView(),
          _articlesView(_homeManager),
        ],
      ),
    );
  }

  /// View: Banner
  Widget _bannerView(BuildContext context) {
    HomeManager manager = Provider.of<HomeManager>(context, listen: false);
    List<BannerInfo> banners = manager.banner;
    return Container(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20.0),
      height: 140.0.h,
      child: Swiper(
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          ImageProvider imageProvider;
          String imageURL = banners[index].image;
          if (imageURL.startsWith("http")) {
            imageProvider = CachedNetworkImageProvider(imageURL);
          } else {
            imageProvider = AssetImage(imageURL);
          }
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image(image: imageProvider, fit: BoxFit.fill),
          );
        },
        itemHeight: 140.0.h,
        itemCount: banners.length,
        viewportFraction: 1,
        scale: 0.9,
        pagination: SwiperPagination(),
//        control: SwiperControl(),
        onTap: (index) {
          // manager.clickBanner(index);
        },
      ),
    );
  }

  Widget _moreServiceView() {
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
    return Container(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        height: 130.0.h,
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
                  Text(
                    '更多 >',
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Color.fromRGBO(155, 155, 155, 1)),
                  ),
                ],
              ),
            ),
            // Container(height: 15.0),
            Container(
                child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) =>
                  _noticeTitle('关于新冠疫苗接种报名的通知'),
            ))
          ],
        ));
  }

  Widget _noticeTitle(String text) {
    return Container(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Text(text,
            style: TextStyle(
                fontSize: 14.sp, color: Color.fromRGBO(51, 51, 51, 1))));
  }

  Widget _articlesView(_homeManager) {
    return Selector<HomeManager, UnmodifiableListView<Article>>(
      builder: (BuildContext context, UnmodifiableListView<Article> value,
          Widget? child) {
        return Container(
          // padding: const EdgeInsets.only(left: 0.0, right: 0.0),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: value.length,
            itemBuilder: (BuildContext context, int index) {
              if (value.length != 0) {
                return ArticleItem(value[index], 0, () {});
              } else {
                return ArticleItem(value[index], 1, () {});
              }
            },
          ),
        );
      },
      selector: (BuildContext context, _homeManager) {
        return _homeManager.articlesList;
      },
    );
  }

  Future? _onRefresh() {}

  Future? _onLoadMore() {}
}
