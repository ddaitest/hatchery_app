import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/routers.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:hatchery/common/widget/loading_view.dart';

class ArticleItem extends StatelessWidget {
  final Article article;
  ArticleItem(this.article);

  @override
  Widget build(BuildContext context) => _getItemContainerView(context);

  Widget _getItemContainerView(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Routers.navWebView(article.redirectUrl),
        child: _titleView(context));
  }

  Widget _titleView(BuildContext context) {
    return Container(
        height: 78.0.h,
        padding: const EdgeInsets.only(right: 7.0, left: 7.0, top: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _imageView(article.image),
            Container(width: 12.0.h),
            // _textView(
            //     '短点的像素、density的取值都是一样的，所以需要适配的是长。', '大、屏占比高、长宽比达到了19.5:9甚至更高；'),
            _textView(article.title, article.summary),
          ],
        ));
  }

  Widget _imageView(String imgUrl) {
    return Container(
        height: 60.0.h,
        width: 90.0.w,
        child: CachedNetworkImage(
          imageUrl: imgUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular((6.0)), // 圆角度
            ),
          ),
          placeholder: (context, url) =>
              LoadingView(viewHeight: 60.0, viewWidth: 90.0),
          errorWidget: (context, url, error) =>
              Icon(Icons.image_not_supported_outlined),
        ));
  }

  Widget _textView(String title, String subtitle) {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Flavors.textStyles.articleTitle,
            ),
            Container(height: 12.0.w),
            Text(
              subtitle,
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Flavors.textStyles.articleSummary,
            ),
          ],
        ),
      ),
    );
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
        height: 78.0.h,
        padding: const EdgeInsets.only(right: 7.0, left: 7.0, top: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _imageView(),
            Container(width: 12.0.h),
            _textView(),
          ],
        ));
  }

  Widget _textView() {
    return Expanded(
        child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoadingView(
              viewHeight: 20.0, viewWidth: Flavors.sizesInfo.screenWidth),
          Container(height: 12.0.w),
          LoadingView(
              viewHeight: 15.0, viewWidth: Flavors.sizesInfo.screenWidth / 2),
        ],
      ),
    ));
  }

  Widget _imageView() {
    return LoadingView(viewHeight: 60, viewWidth: 90.0);
  }
}
