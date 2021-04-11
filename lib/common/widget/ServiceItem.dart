import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceItem extends StatelessWidget {
  String image;
  String text;

  ServiceItem(this.image, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            image,
            height: 30.0.h,
            width: 30.0.w,
          ),
          SizedBox(height: 8.0.h),
          Text(text,
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF666666)))
        ],
      ),
    );
  }
}
