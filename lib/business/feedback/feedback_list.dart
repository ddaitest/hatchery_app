import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/common/AppContext.dart';
import 'package:hatchery/common/log.dart';
import 'package:hatchery/common/widget/app_bar.dart';
import 'package:hatchery/common/widget/list_wrapper.dart';
import 'package:hatchery/manager/feedback_manager.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:hatchery/common/widget/list_item.dart';
import 'package:hatchery/routers.dart';
import 'package:hatchery/common/widget/feedBackDetail_common.dart';

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
    Log.log("FeedbackListPage.initState", color: LColor.RED);
    super.initState();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBarFactory.getCommon("问题反馈"),
        body: Container(
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
              children: [_topPart(), _listPart()],
            ),
          ),
        ));
  }

  void _onRefresh() async {
    Log.log("FeedbackListPage._onRefresh", color: LColor.RED);
    App.manager<FeedbackManager>()
        .refresh()
        .then((value) => value.handle(_refreshController));
  }

  void _onLoading() async {
    Log.log("FeedbackListPage._onLoading", color: LColor.RED);
    App.manager<FeedbackManager>()
        .loadMore()
        .then((value) => value.handle(_refreshController));
  }

  Widget _topPart() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
        color: Color(0xFFFFFFFF),
      ),
      child: TextButton(
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
          children: value
              .map((e) => GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => FeedBackDetail(
                                feedbackInfo: e,
                              ))),
                  child: ListItemView(e)))
              .toList(),
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
