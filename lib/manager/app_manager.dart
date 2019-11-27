import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppManager extends ChangeNotifier {
  int _m = 0;

  int get m => _m;

  String _splashUrl = 'images/welcome.png';

  String get splashUrl => _splashUrl;

  String _webviewUrl = 'https://www.baidu.com/';

  String get WebViewUrl => _webviewUrl;

  ///服务tab顶部
  var ServiceTopMap = {
    "0": "物业服务",
    "1": "家电维修",
    "2": "保姆月嫂",
    "3": "洗车",
    "4": "便民服务",
    "5": "房屋租售",
    "6": "各种服务",
    "7": "其他",
  };
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
