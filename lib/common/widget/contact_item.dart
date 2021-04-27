import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/common/widget/webview_common.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:hatchery/common/widget/loading_view.dart';
import 'package:hatchery/flavors/Flavors.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;

  ContactItem(this.contact);

  @override
  Widget build(BuildContext context) => _listViewContainerMain();

  Widget _listViewContainerMain() {
    return Container(
      padding: const EdgeInsets.only(left: 7.0, right: 7.0, top: 7.0),
      child: _listItem(),
    );
  }

  Widget _listItem() {
    return Container(
      padding: const EdgeInsets.only(
          left: 16.0, right: 16.0, top: 18.0, bottom: 18.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
        color: Color(0xFFFFFFFF),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text('${contact.name}',
                      style: Flavors.textStyles.contactTitle),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12.0,
                  color: Color(0xFFCCCCCC),
                )
              ],
            ),
          ),
          SizedBox(height: 7.0.h),
          Container(
            child: Text('电话：${contact.phone}',
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Flavors.textStyles.contactPhone),
          ),
          SizedBox(height: 8.0.h),
          Container(
            child: Text('说明：${contact.content}',
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Flavors.textStyles.contactSummary),
          ),
        ],
      ),
    );
  }
}
