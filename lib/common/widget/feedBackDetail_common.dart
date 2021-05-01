import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatchery/api/entity.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:hatchery/common/widget/app_bar.dart';
import 'package:hatchery/common/widget/loading_view.dart';
import 'package:hatchery/flavors/Flavors.dart';

class FeedBackDetail extends StatelessWidget {
  final FeedbackInfo? feedbackInfo;

  FeedBackDetail({this.feedbackInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarFactory.getCommon("问题详情"),
      body: _containerMainView(),
    );
  }

  Widget _containerMainView() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _topView(),
          _descMainView(),
          _phoneMainView(),
          _imageMainView(),
        ],
      ),
    );
  }

  Widget _topView() {
    return Container(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${feedbackInfo!.createTime}',
            textAlign: TextAlign.left,
            style: Flavors.textStyles.feedBackDetailTime,
          ),
          Container(height: 2.0.h),
          Text(
            '${feedbackInfo!.title}',
            textAlign: TextAlign.left,
            style: Flavors.textStyles.feedBackDetailTitle,
          )
        ],
      ),
    );
  }

  Widget _descMainView() {
    return Container(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.description_outlined,
                  size: 25.0,
                  color: Color(0xFF000000),
                ),
                Container(width: 14.0.w),
                Text(
                  '问题描述',
                  style: Flavors.textStyles.feedBackDetailSort,
                )
              ],
            ),
            _descText()
          ],
        ));
  }

  Widget _descText() {
    return Container(
      padding: const EdgeInsets.only(left: 40.0, top: 16.0),
      child: Text(
        '${feedbackInfo!.contents}',
        textAlign: TextAlign.left,
        style: Flavors.textStyles.feedBackDetailDesc,
      ),
    );
  }

  Widget _phoneMainView() {
    return Container(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.phone_in_talk_outlined,
                  size: 25.0,
                  color: Color(0xFF000000),
                ),
                Container(width: 14.0.w),
                Text(
                  '联系电话',
                  style: Flavors.textStyles.feedBackDetailSort,
                )
              ],
            ),
            _phoneText()
          ],
        ));
  }

  Widget _phoneText() {
    return Container(
      padding: const EdgeInsets.only(left: 40.0, top: 16.0),
      child: Text(
        '${feedbackInfo!.phone}',
        textAlign: TextAlign.left,
        style: Flavors.textStyles.feedBackDetailDesc,
      ),
    );
  }

  Widget _imageMainView() {
    return Container(
        child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.camera_alt_outlined,
              size: 25.0,
              color: Color(0xFF000000),
            ),
            Container(width: 14.0.w),
            Text(
              '反馈图片',
              style: Flavors.textStyles.feedBackDetailSort,
            )
          ],
        ),
        _imageInfo()
      ],
    ));
  }

  Widget _imageInfo() {
    return Container(
      height: 140.0.h,
      padding: const EdgeInsets.only(left: 40.0, top: 16.0),
      child: GridView.count(
        crossAxisSpacing: 10.0.w,
        mainAxisSpacing: 10.0.h,
        crossAxisCount: 4,
        children: [
          _imageView(feedbackInfo!.img1),
          _imageView(feedbackInfo!.img2),
          _imageView(feedbackInfo!.img3),
          _imageView(feedbackInfo!.img4),
          _imageView(feedbackInfo!.img5),
          _imageView(feedbackInfo!.img6),
        ],
      ),
    );
  }

  Widget _imageView(String? imageUrl) {
    if (imageUrl != null) {
      return Container(
          width: 64.0.w,
          height: 64.0.h,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => PhotoViewPage(imageProvider))),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  LoadingView(viewHeight: 64.0.h, viewWidth: 64.0.w),
              errorWidget: (context, url, error) => Icon(
                Icons.image_not_supported_outlined,
                size: 64.0,
              ),
            ),
          ));
    } else {
      return Container();
    }
  }
}

class PhotoViewPage extends StatelessWidget {
  final ImageProvider? image;

  PhotoViewPage(this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          padding: const EdgeInsets.all(20.0),
          icon: Icon(
            Icons.arrow_back,
            size: 30.0,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        brightness: Brightness.light,
        elevation: 0,
      ),
      body: _photoView(image!),
    );
  }

  Widget _photoView(ImageProvider imageInfo) {
    return Container(
        width: Flavors.sizesInfo.screenWidth,
        height: Flavors.sizesInfo.screenHeight,
        child: PhotoView(
          imageProvider: imageInfo,
        ));
  }
}
