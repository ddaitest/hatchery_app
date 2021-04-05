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
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20.0),
          height: 71.0.h,
          child: _titleView(),
          width: 275.0.w,
        ));
  }

  Widget _titleView() {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 10.0, right: 10.0),
      leading: _imageView(article.avatar),
      title: Text(
        article.title,
        textAlign: TextAlign.left,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 16, color: Color.fromRGBO(51, 51, 51, 1)),
      ),
      subtitle: Text(
        article.contentsShort,
        textAlign: TextAlign.left,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 14, color: Color.fromRGBO(155, 155, 155, 1)),
      ),
    );
  }

  Widget _imageView(String imgUrl) {
    return Container(
        height: 70.0.h,
        width: 70.0.w,
        child: CachedNetworkImage(
          imageUrl: imgUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular((8.0)),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0.0, 2.0), //阴影xy轴偏移量
                      blurRadius: 4.0, //阴影模糊程度
                      spreadRadius: 0.0 //阴影扩散程度
                      )
                ] // 圆角度
                ),
          ),
          errorWidget: (context, url, error) =>
              Icon(Icons.image_not_supported_outlined),
        ));
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
