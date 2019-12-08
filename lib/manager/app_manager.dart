import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hatchery/manager/beans.dart';
import 'dart:collection';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:hatchery/common/api.dart';

class AppManager extends ChangeNotifier {
  int _m = 0;

  int get m => _m;

  String _webviewUrl = 'https://www.baidu.com/';

  String get WebViewUrl => _webviewUrl;

  List<phoneNumberInfo> _phoneNumbersList = [];

  UnmodifiableListView<phoneNumberInfo> get PhoneNumbersList =>
      UnmodifiableListView(_phoneNumbersList);

  int get total => _phoneNumbersList.length;

  AppManager() {
    queryPhoneNumData();
  }

  showToast(String title) {
    Fluttertoast.showToast(
        msg: title,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Color(0x99000000),
        textColor: Colors.white,
        fontSize: 15.0);
  }

  copyData(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  callPhoneNum(String number) async {
    if (await canLaunch("tel:${number}")) {
      await launch("tel:${number}");
    } else {
      throw 'Could not launch $number';
    }
  }

  shareFrame(String contents) {
    Share.share(contents);
  }

  queryPhoneNumData() async {
    Response response = await Api.queryPhoneNumList();
    if (response.data != null) {
      final parsed = json.decode(response.data)['numberlist'] ?? null;
//      var resultCode = parsed['code'] ?? 0;
      for (var x in parsed) {
        add(phoneNumberInfo.fromJson(x));
      }
//      print("LC->#### ${_phoneNumbersList}");
    }
  }

  void add(phoneNumberInfo item) {
    _phoneNumbersList.add(item);
    notifyListeners();
  }
}

///跳转动画
class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
