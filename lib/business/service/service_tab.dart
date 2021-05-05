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
import 'package:hatchery/flavors/Flavors.dart';
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
    // Provider.of<ServiceManager>(context, listen: false).refresh();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

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
          children: [
            _topPart(context),
            _listPart(),
          ],
        ),
      ),
    );
  }

  void _onRefresh() async {
    App.manager<ServiceManager>()
        .refresh()
        .then((value) => value.handle(_refreshController));
  }

  void _onLoading() async {
    App.manager<ServiceManager>()
        .loadMore()
        .then((value) => value.handle(_refreshController));
  }

  Widget _topPart(BuildContext context) {
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
    return Container(
        padding: const EdgeInsets.all(7.0),
        child: Selector<ServiceManager, List<Article>>(
          builder: (context, value, child) {
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
          selector: (BuildContext context, ServiceManager manager) {
            return manager.articles;
          },
          shouldRebuild: (pre, next) =>
              ((pre != next) || (pre.length != next.length)),
        ));
  }

  Widget _computeTopServiceView(List<ServiceInfo> data) {
    ServiceManager manager = App.manager<ServiceManager>();
    List<Widget> views = <Widget>[];
    //generator first line.
    if (data.length > 3) {
      views.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: data
            .sublist(0, 4)
            .map((e) =>
                ServiceItem(e.image, e.name, () => manager.clickService(e)))
            .toList(),
      ));
    }
    //generator second line.
    if (data.length > 4) {
      views.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: data
            .sublist(4)
            .map((e) =>
                ServiceItem(e.image, e.name, () => manager.clickService(e)))
            .toList(),
      ));
      views.insert(1, SizedBox(height: 12.0));
    }
    return Container(
      width: Flavors.sizesInfo.screenWidth,
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: views,
      ),
    );
  }
}
