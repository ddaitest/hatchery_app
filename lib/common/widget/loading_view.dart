import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/common/widget/webview_common.dart';
import 'package:skeleton_text/skeleton_text.dart';

class LoadingView extends StatelessWidget {
  /// type=0 图片loading，viewWidth 和 viewHeight不能为null
  /// type=1 文字loading，viewWidth 和 viewHeight可以为null
  final int? type;
  final double? viewWidth;
  final double? viewHeight;
  LoadingView(this.type, {this.viewWidth, this.viewHeight});

  @override
  Widget build(BuildContext context) => _getContainerView();

  Widget _getContainerView() {
    if (type == 0) {
      return SkeletonAnimation(
        shimmerColor: Colors.grey[400]!,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: viewWidth!.w,
          height: viewHeight!.h,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    } else if (type == 1) {
      return SkeletonAnimation(
        shimmerColor: Colors.grey[400]!,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: viewHeight!.h,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.only(bottom: 10),
        ),
      );
    } else {
      return Container();
    }
  }
}
