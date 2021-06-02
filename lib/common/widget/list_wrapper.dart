import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hatchery/flavors/default.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../PageStatus.dart';

Widget getSimpleHeader() {
  TextStyle style = const TextStyle(color: Colors.grey);
  return WaterDropHeader(
    complete: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.done,
          color: Colors.grey,
        ),
        Container(
          width: 15.0,
        ),
        Text(
          StringsInfo().load_complete,
          style: style,
        )
      ],
    ),
    failed: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.close,
          color: Colors.grey,
        ),
        Container(
          width: 15.0,
        ),
        Text(StringsInfo().refresh_fail, style: TextStyle(color: Colors.grey))
      ],
    ),
  );
}

Widget getSimpleFooter() {
  return CustomFooter(
    builder: (BuildContext context, LoadStatus? mode) {
      Widget body;
      if (mode == LoadStatus.idle) {
        body = Text("上拉加载更多");
      } else if (mode == LoadStatus.loading) {
        body = CupertinoActivityIndicator();
      } else if (mode == LoadStatus.failed) {
        body = Text("加载失败！点击重试");
      } else if (mode == LoadStatus.canLoading) {
        body = Text("松开 加载更多");
      } else {
        body = Text("没有更多数据");
      }
      return Container(
        height: 55.0,
        child: Center(child: body),
      );
    },
  );
}

extension LoadStatusHandler on PageLoadStatus {
  handle(RefreshController controller) {
    switch (this) {
      case PageLoadStatus.canLoading:
        controller.loadComplete();
        break;
      case PageLoadStatus.noMore:
        controller.loadNoData();
        break;
      case PageLoadStatus.failed:
        controller.loadFailed();
        break;
    }
  }
}

extension RefreshStatusHandler on PageRefreshStatus {
  handle(RefreshController controller) {
    switch (this) {
      case PageRefreshStatus.completed:
        controller.refreshCompleted();
        break;
      case PageRefreshStatus.failed:
        controller.refreshFailed();
        break;
    }
  }
}
