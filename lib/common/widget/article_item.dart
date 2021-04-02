import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatchery/common/widget/webview_common.dart';
import 'package:hatchery/manager/beans.dart';

class ArticleItem extends StatelessWidget {
  final ArticleDataInfo article;
  final Function onTap;

  ArticleItem(this.article, this.onTap);

  @override
  Widget build(BuildContext context) => _getItemContainerView(context);

  Widget _getItemContainerView(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (article.redirectUrl != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebViewPage(article.redirectUrl, null)),
          );
        }
      },
      child: Container(
        child: Row(
          children: <Widget>[
            _imageView(article.avatar),
            Container(
                child: _titleView(),
                width: (MediaQuery.of(context).size.width - 116).w),
          ],
        ),
      ),
    );
  }

  Widget _titleView() {
    return Container(
      child: ListTile(
        title: Text(
          article.title,
          textAlign: TextAlign.left,
          overflow: TextOverflow.visible,
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        subtitle: Text(
          article.contentsShort,
          textAlign: TextAlign.left,
          overflow: TextOverflow.visible,
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _imageView(String imgUrl) {
    return imgUrl == ''
        ? Container(
            margin:
                EdgeInsets.only(left: 8.0, top: 3.0, right: 8.0, bottom: 3.0),
            width: 100.0.w)
        : Container(
            child: CachedNetworkImage(
              height: 90.0.h,
              width: 90.0.w,
              imageUrl: imgUrl,
              fit: BoxFit.fill,
            ),
            margin:
                EdgeInsets.only(left: 8.0, top: 3.0, right: 8.0, bottom: 3.0),
            width: 100.0.w,
          );
  }
}

Widget _getMoreWidget() {
  return Center(
    child: Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '加载中...  ',
            style: TextStyle(fontSize: 16.0),
          ),
          CircularProgressIndicator(
            strokeWidth: 1.0,
          )
        ],
      ),
    ),
  );
}

Widget _noMoreWidget() {
  return Center(
    child: Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '已经是最后一条了',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    ),
  );
}
