import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppID {
  final appid = 001;
}

class Strings {
  final title = "默认小区名";
  final post = "物业公告";
}

class TextStyles {
  final TextStyle title =
      const TextStyle(fontSize: 27.0, color: Colors.black87);

  final TextStyle title1 =
      const TextStyle(fontSize: 20.0, color: Colors.black87);

  final TextStyle title2 =
      const TextStyle(fontSize: 18.0, color: Colors.black87);

  final TextStyle content =
      const TextStyle(fontSize: 16.0, color: Colors.black54);

  final TextStyle secondary =
      const TextStyle(fontSize: 16.0, color: Colors.black38);

  final TextStyle splashFont = const TextStyle(
      fontSize: 27.0,
      height: 1.5,
      fontWeight: FontWeight.w500,
      color: Colors.white);
  final TextStyle splashFontNow = const TextStyle(
      fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.black);

  final TextStyle articleTitle =
      const TextStyle(fontSize: 20.0, color: Colors.black87);
  final TextStyle articleSummary =
      const TextStyle(fontSize: 18.0, color: Colors.black54);
  final TextStyle articleDate =
      const TextStyle(fontSize: 18.0, color: Colors.black38);
}

class AgreementPageTextStyle {
  final TextStyle mainTitle = const TextStyle(
      fontSize: 27.0, color: Colors.black87, fontWeight: FontWeight.w500);

  final TextStyle subtitleTitle =
      const TextStyle(fontSize: 27.0, color: Colors.black87);

  /// 协议title
  TextStyle agreementTitle = TextStyle(
      fontSize: 19.0, color: Colors.black, fontWeight: FontWeight.w500);

  /// 协议提示文字
  TextStyle agreementText =
      TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400);

  /// 确认按钮
  TextStyle confirmBtn = TextStyle(fontSize: 18.0);

  /// 关闭app按钮
  TextStyle closeAppBtn = TextStyle(color: Colors.grey, fontSize: 14);
}

class Sizes {
  final articleItemHeight = 120.0;
  final articleThumbnail = 100.0;
  final postItemHeight = 60.0;
}

class Color {
  final diver = Colors.black87;
}
