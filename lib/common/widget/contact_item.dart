import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/common/widget/webview_common.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:hatchery/common/widget/loading_view.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;

  ContactItem(this.contact);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 8),
        child: ListTile(
          trailing: Icon(Icons.keyboard_arrow_right),
          title: Text(
            contact.name,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          subtitle: Text("${contact.phone}\n${contact.content}"),
          onTap: () {
            // manager.callPhoneNum(data.phone);
          },
          onLongPress: () {
            Clipboard.setData(ClipboardData(text: contact.phone));
            // manager.shareFrame("${data.name}\n${data.phone}");
            //Share.share(contents);
          },
        ));
  }
}
