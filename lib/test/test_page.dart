import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:hatchery/manager/serivce_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:hatchery/common/widget/webview_common.dart';

class ServiceTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: MySliverAppBar(expandedHeight: 200),
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) => ListTile(
                  title: Text("Index: $index"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({@required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Image.network(
          "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          fit: BoxFit.cover,
        ),
        Opacity(
          opacity: shrinkOffset / expandedHeight,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _topButtons(CommunityMaterialIcons.account_card_details,
                    Colors.white, "物业服务", Colors.white, 0),
                _topButtons(CommunityMaterialIcons.account_card_details,
                    Colors.white, "物业服务", Colors.white, 0),
                _topButtons(CommunityMaterialIcons.account_card_details,
                    Colors.white, "物业服务", Colors.white, 0),
                _topButtons(CommunityMaterialIcons.account_card_details,
                    Colors.white, "物业服务", Colors.white, 0),
              ],
            ),
          ),
        ),
        Positioned(
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        _topButtons(CommunityMaterialIcons.account_card_details,
                            Colors.red, "设施保修", Colors.white, 0),
                        _topButtons(CommunityMaterialIcons.account_card_details,
                            Colors.red, "设施保修", Colors.white, 0),
                        _topButtons(CommunityMaterialIcons.account_card_details,
                            Colors.red, "设施保修", Colors.white, 0),
                        _topButtons(CommunityMaterialIcons.account_card_details,
                            Colors.red, "设施保修", Colors.white, 0),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        _topButtons(CommunityMaterialIcons.account_card_details,
                            Colors.red, "设施保修", Colors.white, 0),
                        _topButtons(CommunityMaterialIcons.account_card_details,
                            Colors.red, "设施保修", Colors.white, 0),
                        _topButtons(CommunityMaterialIcons.account_card_details,
                            Colors.red, "设施保修", Colors.white, 0),
                        _topButtons(CommunityMaterialIcons.account_card_details,
                            Colors.red, "设施保修", Colors.white, 0),
                      ],
                    ),
                  ),
                ]),
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

_topButtons(IconName, IconColor, String name, nameColor, int tapNum) {
  return MaterialButton(
    onPressed: () {
//      manager.getListData(tapNum);
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          IconName,
          size: 35,
          color: IconColor,
        ),
        Text(
          name,
          style: TextStyle(color: nameColor, fontSize: 12),
        ),
      ],
    ),
  );
}
