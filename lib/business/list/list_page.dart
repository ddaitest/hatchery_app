import 'package:flutter/material.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/common/AppContext.dart';
import 'package:hatchery/common/widget/article_item.dart';
import 'package:hatchery/common/widget/list_wrapper.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'list_manager.dart';

class ListPage extends StatefulWidget {
  final String serviceId;
  final String title;

  ListPage(this.title, this.serviceId);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => false;

  @override
  void initState() {
    super.initState();
    App.manager<ListPageManager>().init(widget.serviceId);
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          elevation: 0,
        ),
        body: Container(
          color: Colors.white,
          child: SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            enablePullUp: true,
            header: getSimpleHeader(),
            footer: getSimpleFooter(),
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: _listPart(),
          ),
        ));
  }

  void _onRefresh() async {
    App.manager<ListPageManager>()
        .refresh()
        .then((value) => value.handle(_refreshController));
  }

  void _onLoading() async {
    App.manager<ListPageManager>()
        .loadMore()
        .then((value) => value.handle(_refreshController));
  }

  Widget _listPart() {
    return Selector<ListPageManager, List<Article>>(
      builder: (context, value, child) {
        return ListView.builder(
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
        );
      },
      selector: (BuildContext context, ListPageManager manager) {
        return manager.data;
      },
      shouldRebuild: (pre, next) =>
          ((pre != next) || (pre.length != next.length)),
    );
  }
}
