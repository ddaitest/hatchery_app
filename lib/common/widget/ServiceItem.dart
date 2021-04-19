import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatchery/flavors/Flavors.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              image,
              height: 30.0.h,
              width: 30.0.w,
            ),
            SizedBox(height: 4.0.h),
            Text(text, style: Flavors.textStyles.serviceTitle)
          ],
        ),
      ),
    );
  }
}
