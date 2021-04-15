import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/routers.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hatchery/common/widget/loading_view.dart';

class BannerCommonView extends StatelessWidget {
  final List<BannerInfo> bannerLists;
  final double bannerHeight;

  BannerCommonView(this.bannerLists, {this.bannerHeight = 92.0});

  @override
  Widget build(BuildContext context) => _bannerContainerView(context);

  Widget _bannerContainerView(BuildContext context) {
    return bannerLists.isNotEmpty
        ? Container(
            padding: const EdgeInsets.only(left: 7.0, right: 7.0),
            height: bannerHeight.h,
            child: Swiper(
              autoplay: bannerLists.length != 1 ? true : false,
              physics: bannerLists.length != 1
                  ? const AlwaysScrollableScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  child: CachedNetworkImage(
                    // imageUrl:
                    //     'https://img.zcool.cn/community/01d56b5542d8bc0000019ae98da289.jpg@1280w_1l_2o_100sh.png',
                    imageUrl: bannerLists[index].image,
                    fit: BoxFit.fitWidth,
                    placeholder: (context, url) => LoadingView(
                        viewHeight: bannerHeight.h,
                        viewWidth: Flavors.sizesInfo.screenWidth),
                    errorWidget: (context, url, error) => Icon(
                      Icons.image_not_supported_outlined,
                      size: 40.0,
                    ),
                  ),
                );
              },
              itemHeight: bannerHeight.h,
              itemCount: bannerLists.length,
              viewportFraction: 1,
              scale: 0.9,
              pagination: bannerLists.length != 1
                  ? SwiperPagination()
                  : SwiperPagination(builder: SwiperPagination.rect),
              onTap: (index) =>
                  Routers.navWebView(bannerLists[index].redirectUrl),
            ),
          )
        : Container(
            padding: const EdgeInsets.only(left: 7.0, right: 7.0),
            height: bannerHeight.h,
            child: Swiper(
              autoplay: false,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  child: LoadingView(
                      viewHeight: bannerHeight.h,
                      viewWidth: Flavors.sizesInfo.screenWidth),
                );
              },
              itemHeight: bannerHeight.h,
              itemCount: 1,
              viewportFraction: 1,
              scale: 0.9,
              pagination:
                  const SwiperPagination(builder: SwiperPagination.rect),
            ),
          );
  }
}
