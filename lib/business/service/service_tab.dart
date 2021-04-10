import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/common/AppContext.dart';
import 'package:hatchery/common/PageStatus.dart';
import 'package:hatchery/common/widget/ServiceItem.dart';
import 'package:hatchery/common/widget/article_item.dart';
import 'package:hatchery/common/widget/list_wrapper.dart';
import 'package:provider/provider.dart';
import 'package:hatchery/manager/service_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hatchery/common/widget/webview_common.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatchery/common/exts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ServiceTab extends StatefulWidget {
  @override
  ServiceTabState createState() => ServiceTabState();
}

class ServiceTabState extends State<ServiceTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Provider.of<ServiceManager>(context, listen: false).refresh();
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
        children: [_topPart(context), _listPart()],
      ),
    );
  }

  void _onRefresh() async {
    Provider.of<ServiceManager>(context, listen: false).refresh().then((value) {
      switch (value) {
        case PageRefreshStatus.completed:
          _refreshController.refreshCompleted();
          break;
        case PageRefreshStatus.failed:
          _refreshController.refreshFailed();
          break;
      }
    });
  }

  void _onLoading() async {
    // AppContext.getManager<ServiceManager>().loadMore();
    Provider.of<ServiceManager>(context, listen: false).loadMore().then((value) {
      switch (value) {
        case PageLoadStatus.canLoading:
          _refreshController.loadComplete();
          break;
        case PageLoadStatus.noMore:
          _refreshController.loadNoData();
          break;
        case PageLoadStatus.failed:
          _refreshController.loadFailed();
          break;
      }
    });
  }

  Widget _topPart(BuildContext context) {
    // return SliverToBoxAdapter(
    //   child: Container(
    //     child: Selector<ServiceManager, List<ServiceInfo>>(
    //       builder: (context, value, child) {
    //         return _computeTopServiceView(value);
    //       },
    //       selector: (BuildContext context, ServiceManager manager) {
    //         return manager.services;
    //       },
    //       shouldRebuild: (pre, next) =>
    //           ((pre != next) || (pre.length != next.length)),
    //     ),
    //   ),
    // );
    return Selector<ServiceManager, List<ServiceInfo>>(
      builder: (context, value, child) {
        return _computeTopServiceView(value);
      },
      selector: (BuildContext context, ServiceManager manager) {
        return manager.services;
      },
      shouldRebuild: (pre, next) =>
          ((pre != next) || (pre.length != next.length)),
    );
  }

  Widget _listPart() {
    // var data = AppContext.getManager<ServiceManager>(listen: true).articles;
    // var data = Provider.of<ServiceManager>(context, listen: false).articles;
    // return SliverList(
    //   delegate: SliverChildBuilderDelegate(
    //     (BuildContext context, int index) {
    //       return ArticleItem(data[index]);
    //     },
    //     childCount: data.length,
    //   ),
    // );
    return Selector<ServiceManager, List<Article>>(
      builder: (context, value, child) {
        return Column(
          children: value.map((e) => ArticleItem(e)).toList(),
        );
      },
      selector: (BuildContext context, ServiceManager manager) {
        return manager.articles;
      },
      shouldRebuild: (pre, next) =>
          ((pre != next) || (pre.length != next.length)),
    );
  }

  Widget _computeTopServiceView(List<ServiceInfo> data) {
    var views = <Widget>[];
    //generator first line.
    if (data.length > 3) {
      views.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: data
            .sublist(0, 4)
            .map((e) => ServiceItem('images/image1.png', e.name))
            .toList(),
      ));
    }
    //generator second line.
    if (data.length > 4) {
      views.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: data
            .sublist(4)
            .map((e) => ServiceItem('images/image1.png', e.name))
            .toList(),
      ));
    }
    return Container(
      child: Column(
        children: views,
      ),
    );
  }
}
