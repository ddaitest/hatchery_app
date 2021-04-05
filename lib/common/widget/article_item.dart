import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatchery/common/widget/webview_common.dart';
import 'package:hatchery/manager/beans.dart';
import 'package:skeleton_text/skeleton_text.dart';

class ArticleItem extends StatelessWidget {
  final ArticleDataInfo article;
  final int loadingStatus;
  final Function onTap;

  /// loadingStatus = 1 有数据的item
  /// loadingStatus = 0 无数据的item
  ArticleItem(this.article, this.loadingStatus, this.onTap);

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
        child: _titleView());
  }

  Widget _titleView() {
    return Container(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20.0),
      height: 71.0.h,
      width: 275.0.w,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10.0, right: 10.0),
        leading: _imageView(article.avatar),
        title: loadingStatus == 1
            ? Text(
                article.title,
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 16, color: Color.fromRGBO(51, 51, 51, 1)),
              )
            : SkeletonAnimation(
                shimmerColor: Colors.grey,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  // width: 200.0.w,
                  height: 15.0.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.only(bottom: 10),
                ),
              ),
        subtitle: loadingStatus == 1
            ? Text(
                article.contentsShort,
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 14, color: Color.fromRGBO(155, 155, 155, 1)),
              )
            : SkeletonAnimation(
                shimmerColor: Colors.grey,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  // width: 100.0.w,
                  height: 15.0.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _imageView(String imgUrl) {
    return loadingStatus == 1
        ? Container(
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
            ))
        : SkeletonAnimation(
            shimmerColor: Colors.grey,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 70.0.w,
              height: 70.0.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
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
