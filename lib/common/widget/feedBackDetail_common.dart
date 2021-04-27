import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/common/widget/webview_common.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:hatchery/common/widget/loading_view.dart';
import 'package:hatchery/flavors/Flavors.dart';

class FeedBackDetail extends StatelessWidget {
  final FeedbackInfo? feedbackInfo;

  FeedBackDetail({this.feedbackInfo});

  @override
  Widget build(BuildContext context) {
    print("DEBUG=> feedbackInfo $feedbackInfo");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "问题详情",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0.5,
      ),
      body: _containerMainView(),
    );
  }

  Widget _containerMainView() {
    return Container(
      padding: const EdgeInsets.only(left: 7.0, right: 7.0, top: 7.0),
      child: Column(
        children: [
          _topView(),
          _descMainView(),
          _imageMainView(),
        ],
      ),
    );
  }

  Widget _topView() {
    return Container(
      child: Column(
        children: [
          Text('${feedbackInfo!.title}'),
          Text('${feedbackInfo!.createTime}')
        ],
      ),
    );
  }

  Widget _descMainView() {
    return Container(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 20.0,
              color: Color(0xFF000000),
            ),
            Text('问题描述')
          ],
        ),
        _descText()
      ],
    ));
  }

  Widget _descText() {
    return Container(
      child: Text('${feedbackInfo!.contents}'),
    );
  }

  Widget _imageMainView() {
    return Container(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.camera_alt_outlined,
              size: 20.0,
              color: Color(0xFF000000),
            ),
            Text('反馈图片')
          ],
        ),
        _imageInfo()
      ],
    ));
  }

  Widget _imageInfo() {
    return Container(
      child: GridView.count(
        crossAxisSpacing: 10.0.w,
        mainAxisSpacing: 10.0.h,
        crossAxisCount: 4,
        children: [_imageView('11')],
      ),
    );
  }

  Widget _imageView(String imageUrl) {
    return Container(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
      ),
    );
  }
}
