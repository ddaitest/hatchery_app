import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/common/widget/webview_common.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:hatchery/common/widget/loading_view.dart';

class ArticleItem extends StatelessWidget {
  final Article article;
  ArticleItem(this.article);

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
        leading: _imageView(article.image),
        title: Text(
          article.title,
          textAlign: TextAlign.left,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 16, color: Color.fromRGBO(51, 51, 51, 1)),
        ),
        subtitle: Text(
          article.summary,
          textAlign: TextAlign.left,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style:
              TextStyle(fontSize: 14, color: Color.fromRGBO(155, 155, 155, 1)),
        ),
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
              borderRadius: BorderRadius.circular((8.0)), // 圆角度
            ),
          ),
          placeholder: (context, url) =>
              LoadingView(1, viewHeight: 70.0, viewWidth: 70.0),
          errorWidget: (context, url, error) =>
              Icon(Icons.image_not_supported_outlined),
        ));
  }
}

class ArticleItemLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _getItemContainerView(context);

  Widget _getItemContainerView(BuildContext context) {
    return _titleView();
  }

  Widget _titleView() {
    return Container(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20.0),
      height: 71.0.h,
      width: 275.0.w,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10.0, right: 10.0),
        leading: _imageView(),
        title: LoadingView(1, viewHeight: 15.0),
        subtitle: LoadingView(1, viewHeight: 15.0),
      ),
    );
  }

  Widget _imageView() {
    return LoadingView(0, viewHeight: 70.0, viewWidth: 70.0);
  }
}
