import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/common/DateUtil.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:hatchery/manager/beans.dart';

class NoticeItem extends StatelessWidget {
  final Notice notice;
  final Function onTap;

  NoticeItem(this.notice, this.onTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: Flavors.sizes.postItemHeight,
        padding: EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(notice.title, maxLines: 2, style: Flavors.styles.content),
                Expanded(child: Container(), flex: 1),
                Text(DateUtil.getDateStrByMs(notice.updateTime,format: DateFormat.MONTH_DAY_HOUR_MINUTE),
                    style: Flavors.styles.content),
              ],
            ),
            Divider(color: Flavors.colors.diver)
          ],
        ),
      ),
      onTap: () => onTap,
    );
  }
}
