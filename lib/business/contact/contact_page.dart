import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/common/AppContext.dart';
import 'package:hatchery/common/utils.dart';
import 'package:hatchery/common/widget/article_item.dart';
import 'package:hatchery/common/widget/contact_item.dart';
import 'package:hatchery/common/widget/list_wrapper.dart';
import 'package:hatchery/manager/contact_manager.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:provider/provider.dart';
import 'package:hatchery/common/backgroundListenModel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  ContactManager _contactManager = ContactManager();
  //   with AutomaticKeepAliveClientMixin {
  // @override
  // bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // App.manager<ContactManager>().refresh();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "物业联系方式",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: true,
        header: getSimpleHeader(),
        footer: getSimpleFooter(),
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: _listPart(),
      ),
    );
  }

  void _onRefresh() async {
    App.manager<ContactManager>()
        .refresh()
        .then((value) => value.handle(_refreshController));
  }

  void _onLoading() async {
    App.manager<ContactManager>()
        .loadMore()
        .then((value) => value.handle(_refreshController));
  }

  Widget _listPart() {
    return Selector<ContactManager, List<Contact>>(
      builder: (context, value, child) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: value.isEmpty ? 3 : value.length,
          itemBuilder: (BuildContext context, int index) {
            if (value.isEmpty) {
              return ArticleItemLoading();
            } else {
              return GestureDetector(
                onTap: () => _showSheetMenu(
                    context, value[index].phone, value[index].name),
                child: ContactItem(value[index]),
              );
            }
          },
        );
      },
      selector: (BuildContext context, ContactManager manager) {
        return manager.contacts;
      },
      shouldRebuild: (pre, next) =>
          ((pre != next) || (pre.length != next.length)),
    );
  }

  _showSheetMenu(BuildContext context, String phoneNumber, String name) {
    BackLock.working = true;
    showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('$name', style: Flavors.textStyles.contactTitle),
        actions: <Widget>[
          CupertinoActionSheetAction(
              child: Text('拨打号码: $phoneNumber'),
              onPressed: () {
                callPhoneNum(phoneNumber);
                Navigator.pop(context);
              }),
          CupertinoActionSheetAction(
              child: const Text('复制电话号码'),
              onPressed: () {
                copyData('$name $phoneNumber');
                showToast('$name 电话复制成功');
                Navigator.pop(context);
              }),
          // CupertinoActionSheetAction(
          //     child: const Text('分享到微信'),
          //     onPressed: () => Navigator.pop(context, 'Camera')),
        ],
        cancelButton: CupertinoActionSheetAction(
            child: const Text('取消'),
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context)),
      ),
    );
  }
}
