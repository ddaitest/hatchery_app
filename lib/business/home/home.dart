import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hatchery/common/widget/article_item.dart';
import 'package:hatchery/common/widget/backgourds.dart';
import 'package:hatchery/common/widget/post_item.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:hatchery/manager/beans.dart';
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
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _onRefresh,
      child: CustomScrollView(
        slivers: <Widget>[
          _banner(context).addSilver(),
          _posts(),
          _articles(),
        ],
      ),
    );
  }

  /// View: Banner
  Widget _banner(BuildContext context) {
    HomeManager manager = Provider.of<HomeManager>(context, listen: false);
    List<BannerInfo> banners = manager.banner;
    return Container(
      height: 140,
      child: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          ImageProvider imageProvider;
          String imageURL = banners[index].imgUrl;
          if (imageURL.startsWith("http")) {
            imageProvider = CachedNetworkImageProvider(imageURL);
          } else {
            imageProvider = AssetImage(imageURL);
          }
          return ClipRRect(
            borderRadius: new BorderRadius.circular(8.0),
            child: Image(image: imageProvider, fit: BoxFit.fill),
          );
        },
        itemHeight: 140,
        itemCount: banners.length,
        viewportFraction: 0.8,
        scale: 0.9,
        pagination: new SwiperPagination(),
//        control: new SwiperControl(),
        onTap: (index) {
          manager.clickBanner(index);
        },
      ),
    );
  }

  Widget _posts() {
    return Selector<HomeManager, UnmodifiableListView<Notice>>(
      selector: (BuildContext context, HomeManager manager) {
        return manager.posts;
      },
      builder: (BuildContext context, UnmodifiableListView<Notice> value,
          Widget child) {
        var postViews = <Widget>[
          _postTitle(),
        ];
        for (Notice d in value) {
          postViews.add(NoticeItem(d, () {}));
        }
        return Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(20),
          child: Column(
            children: postViews,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[200],
                blurRadius: 10.0,
                spreadRadius: 5.0,
              )
            ],
            color: Colors.white,
          ),
        ).addSilver();
      },
    );
  }

  Widget _postTitle() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: 2,
            height: 16,
            color: Flavors.colors.diver,
            margin: EdgeInsets.only(right: 8),
          ),
          Text(Flavors.strings.post),
          Expanded(
            child: Container(),
            flex: 1,
          ),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }

  Widget _articles() {
    return Selector<HomeManager, UnmodifiableListView<ArticleDataInfo>>(
      selector: (BuildContext context, HomeManager manager) {
        return manager.articles;
      },
      builder: (BuildContext context,
          UnmodifiableListView<ArticleDataInfo> value, Widget child) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ArticleItem(value[index], () {});
            },
            childCount: value.length,
          ),
        );
      },
    );
  }

  Future _onRefresh() {}

  Future _onLoadMore() {}
}
