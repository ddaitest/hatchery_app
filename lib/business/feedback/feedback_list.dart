import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/common/AppContext.dart';
import 'package:hatchery/common/widget/app_bar.dart';
import 'package:hatchery/common/widget/list_wrapper.dart';
import 'package:hatchery/manager/feedback_manager.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FeedbackListPage extends StatefulWidget {
  @override
  _FeedbackListPageState createState() => _FeedbackListPageState();
}

class _FeedbackListPageState extends State<FeedbackListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarFactory.getCommon("问题反馈"),
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
            child: ListView(
              children: [_topPart(), _listPart()],
            ),
          ),
        ));
  }

  void _onRefresh() async {
    App.manager<FeedbackManager>()
        .refresh()
        .then((value) => value.handle(_refreshController));
  }

  void _onLoading() async {
    App.manager<FeedbackManager>()
        .loadMore()
        .then((value) => value.handle(_refreshController));
  }

  Widget _topPart() {
    return Container(
      padding: EdgeInsets.all(10),
      child: OutlinedButton(
        child: Text("新建"),
        onPressed: () => App.manager<FeedbackManager>().create(),
      ),
    );
  }

  Widget _listPart() {
    return Selector<FeedbackManager, List<FeedbackInfo>>(
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: value.map((e) => FeedbackItem(e)).toList(),
        );
      },
      selector: (BuildContext context, FeedbackManager manager) {
        return manager.data;
      },
      shouldRebuild: (pre, next) =>
          ((pre != next) || (pre.length != next.length)),
    );
  }
}

class FeedbackItem extends StatelessWidget {
  FeedbackInfo info;

  FeedbackItem(this.info);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        trailing: Icon(Icons.keyboard_arrow_right),
        title: Text(
          info.contents ?? "...",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text("联系方式 ${info.phone}"),
      ),
    );
  }
}
