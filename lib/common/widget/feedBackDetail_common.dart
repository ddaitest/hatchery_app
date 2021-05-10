import 'dart:io';
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
          _createTimeView(),
          _titleView(),
          _descMainView(),
          _phoneMainView(),
          _imageMainView(),
        ],
      ),
    );
  }

  Widget _createTimeView() {
    return Container(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '反馈日期：',
            textAlign: TextAlign.left,
            style: Flavors.textStyles.feedBackDetailSort,
          ),
          Container(width: 8.0.w),
          Text(
            '${feedbackInfo!.createTime}',
            textAlign: TextAlign.left,
            style: Flavors.textStyles.feedBackDetailText,
          )
        ],
      ),
    );
  }

  Widget _titleView() {
    return Container(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '标题：',
            textAlign: TextAlign.center,
            style: Flavors.textStyles.feedBackDetailSort,
          ),
          Container(width: 8.0.w),
          Expanded(
              child: Text(
            '${feedbackInfo!.title}',
            maxLines: 5,
            textAlign: TextAlign.left,
            style: Flavors.textStyles.feedBackDetailText,
          ))
        ],
      ),
    );
  }

  Widget _descMainView() {
    return Container(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '问题描述：',
              style: Flavors.textStyles.feedBackDetailSort,
            ),
            Container(width: 8.0.w),
            _descText()
          ],
        ));
  }

  Widget _descText() {
    return Expanded(
      child: Text(
        '${feedbackInfo!.contents}',
        maxLines: 10,
        textAlign: TextAlign.left,
        style: Flavors.textStyles.feedBackDetailText,
      ),
    );
  }

  Widget _phoneMainView() {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '联系电话：',
          style: Flavors.textStyles.feedBackDetailSort,
        ),
        Container(width: 8.0.w),
        _phoneText()
      ],
    ));
  }

  Widget _phoneText() {
    return Container(
      child: Text(
        '${feedbackInfo!.phone}',
        textAlign: TextAlign.left,
        style: Flavors.textStyles.feedBackDetailText,
      ),
    );
  }

  Widget _imageMainView() {
    if (feedbackInfo!.img1 != null) {
      return Container(
          padding: const EdgeInsets.only(top: 30.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '上传图片：',
                style: Flavors.textStyles.feedBackDetailSort,
              ),
              Container(width: 8.0.w),
              _imageView()
            ],
          ));
    } else {
      return Container();
    }
  }

  Widget _imageView() {
    return Container(
        width: 64.0.w,
        height: 64.0.h,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          child: CachedNetworkImage(
            imageUrl: feedbackInfo!.img1,
            imageBuilder: (context, imageProvider) {
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => PhotoViewPage(image: imageProvider))),
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
  }
}

class PhotoViewPage extends StatelessWidget {
  final ImageProvider? image;
  final File? imageFile;

  PhotoViewPage({this.image, this.imageFile});

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
      body: _photoView(image, file: imageFile),
    );
  }

  Widget _photoView(ImageProvider? imageInfo, {File? file}) {
    return Container(
        width: Flavors.sizesInfo.screenWidth,
        height: Flavors.sizesInfo.screenHeight,
        child: imageInfo == null
            ? PhotoView(
                imageProvider: FileImage(file!),
              )
            : PhotoView(
                imageProvider: imageInfo,
              ));
  }
}
