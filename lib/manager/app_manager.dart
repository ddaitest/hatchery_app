import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hatchery/manager/beans.dart';
import 'dart:collection';

class AppManager extends ChangeNotifier {
  int _m = 0;

  int get m => _m;

  String _splashUrl = 'images/welcome.png';

  String get splashUrl => _splashUrl;

  String _webviewUrl = 'https://www.baidu.com/';

  String get WebViewUrl => _webviewUrl;

  List<Numberlist> _phoneNumbersList = [];

  UnmodifiableListView<Numberlist> get PhoneNumbersList =>
      UnmodifiableListView(_phoneNumbersList);

  var _phoneNumbers =
      '{"numberlist":[{ "phone":"18510336249" , "des":"服务时间8：00 至 22：00" },{ "phone":"18510336247" , "des":"服务时间6：00 至 19：00" },{ "phone":"18510336248" , "des":"服务时间7：00 至 20：00" }]}';

  int get total => _phoneNumbersList.length;

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

  queryPhoneNumData() async {
    final parsed = json.decode(_phoneNumbers)['numberlist'];
    _phoneNumbersList =
        parsed.map<Numberlist>((json) => Numberlist.fromJson(json)).toList();
    print("LC -> ${total}");
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
