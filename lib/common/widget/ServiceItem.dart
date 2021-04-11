import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceItem extends StatelessWidget {
  String image;
  String text;
  GestureTapCallback onTap;

  ServiceItem(this.image, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // height: 50.0.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              image,
              height: 30.0.h,
              width: 30.0.w,
            ),
            SizedBox(height: 10.h),
            Text(text,
                style: TextStyle(
                    fontSize: 13.sp, color: Color.fromRGBO(51, 51, 51, 1)))
          ],
        ),
      ),
    );
  }
}
