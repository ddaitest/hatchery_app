import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatchery/common/tools.dart';
import 'dart:convert';

const bool TEST = true;

class AppID {
  final client_id = '36ff662f-3041-5c10-8bde-65e6fb86523b';
  final splash_page_id = 'tab0';
  final home_page_id = 'tab1';
  final service_page_id = 'tab2';
  final nearby_page_id = 'tab3';
}

class StringsInfo {
  final community_name = "玫瑰园";
  final post_title = "物业公告";
  final articles_title = "便民信息";
  final agreement_card_text =
      '欢迎使用本软件！\n在您使用本软件前，请您认真阅读并同意用户协议和隐私政策，以了解我们的服务内容和我们在收集和使用您相关个人信息时的处理规则。我们将严格按照用户协议和隐私政策为您提供服务，保护您的个人信息。';
  final user_agreement_url = 'https://www.baidu.com/';
  final privacy_agreement_url = 'https://www.sina.com.cn/';
  final main_tab_title = {
    "首页": Icons.home_outlined,
    "服务": Icons.home_repair_service_outlined,
    "周边": Icons.near_me_outlined
  };
  final refresh_complete = "刷新成功";
  final refresh_fail = "刷新失败";
  final load_fail = "加载失败";
  final loading = "加载中...";
  final load_complete = "加载成功";
  final load_no_data = "没有更多数据";
}

class ApiInfo {
  final String API_HOST = 'http://106.12.147.150:8080/';
  final int RESPONSE_STATUS_CODE = 100000;
  final int API_CONNECT_TIMEOUT = 60000;
  final int API_RECEIVE_TIMEOUT = 60000;
  final String CONTENT_TYPE = 'application/json';
  final String BASIC_AUTH =
      'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlzcyI6IjM2ZmY2NjJmLTMwNDEtNWMxMC04YmRlLTY1ZTZmYjg2NTIzYiIsImV4cCI6MTYxNzg5MDkzM30.6-zJZ5Eoq83mx1KAdWs6Fr6gm4wkdXV49tlqKAKJOrU';
}

class LocalSharedPreferences {
  final String Agreement_DATA_KEY = 'agreeAgreementKey';
  final String CONFIG_KEY = 'configKey';
  final String SPLASH_AD_RESPONSE_KEY = 'adResponseKey';
  final String POP_AD_SHOW_TIMES_KEY = 'popShowTimesKey';
  final String COMMON_PARAM_KEY = 'commonParamKey';
}

class TimeConfig {
  final int SPLASH_TIMEOUT = TEST ? 6 : 6;
  final int SPLASH_TIME = TEST ? 1 : 4;
  final int POP_AD_WAIT_TIME = TEST ? 1 : 3;
  final int UPGRADE_LOADING_TIME = TEST ? 1 : 5;
  final int DEFAULT_SHOW_POP_TIMES = TEST ? 30 : 1;
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

  /// 协议title
  final TextStyle agreementTitle = TextStyle(
      fontSize: 19.0, color: Colors.black, fontWeight: FontWeight.w500);

  /// 协议提示文字
  final TextStyle agreementText =
      TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400);

  /// 确认按钮
  final TextStyle agreementConfirmBtn = TextStyle(fontSize: 18.0);

  /// 关闭app按钮
  final TextStyle agreementCloseAppBtn =
      TextStyle(color: Colors.grey, fontSize: 14);

  /// 开屏倒计时
  final TextStyle splashFont = const TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.white);

  /// 分类主标题，如：物业公告
  final TextStyle sortTitle = const TextStyle(
      fontWeight: FontWeight.w400, fontSize: 16.0, color: Color(0xFF333333));

  /// 分类更多按钮
  final TextStyle moreText = const TextStyle(
      fontWeight: FontWeight.w500, fontSize: 14.0, color: Color(0xFF666666));

  /// service text
  final TextStyle serviceTitle = const TextStyle(
      fontSize: 12.0, fontWeight: FontWeight.w400, color: Color(0xFF666666));

  /// 软文主标题
  final TextStyle articleTitle =
      const TextStyle(fontSize: 16.0, color: Color(0xFF333333));

  /// 软文副标题
  final TextStyle articleSummary =
      const TextStyle(fontSize: 13.0, color: Color(0xFF999999));

  /// 软文日期
  final TextStyle articleDate =
      const TextStyle(fontSize: 18.0, color: Colors.black38);

  /// 软文日期
  final TextStyle noticeText =
      const TextStyle(fontSize: 14.0, color: Color(0xFF333333));
}

class AgreementPageTextStyle {
  /// 协议title
  TextStyle agreementTitle = TextStyle(
      fontSize: 19.0, color: Colors.black, fontWeight: FontWeight.w500);
}

class CommonParam {
  final Map<String, dynamic> commonParamMap = getCommonParamMapFromSP() ?? null;

  static getCommonParamMapFromSP() {
    String? _responseResult =
        SP.getString(LocalSharedPreferences().COMMON_PARAM_KEY);
    if (_responseResult != null) {
      Map<String, dynamic>? _finalParse = jsonDecode(_responseResult);
      return _finalParse;
    }
  }
}

class SizesInfo {
  final articleItemHeight = 120.0;
  final articleThumbnail = 100.0;
  final postItemHeight = 60.0;
  final screenWidth = 1.sw; // 屏幕宽度
  final screenHeight = 1.sh; // 屏幕高度
}

class ColorInfo {
  final diver = Colors.black87;
  final homeTabSelected = Color(0xFF006EE7);
  final homeTabUnSelected = Color(0x8A000000);
}
