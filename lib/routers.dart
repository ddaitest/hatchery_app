import 'package:flutter/material.dart';
import 'package:hatchery/common/AppContext.dart';

import 'business/feedback/feedback_list.dart';
import 'business/main_tab.dart';
import 'business/splash/agreementPage.dart';
import 'business/splash/splash.dart';
import 'common/widget/webview_common.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MainTab());
      case '/agreementPage':
        return MaterialPageRoute(builder: (_) => AgreementPage());
      case '/splash':
        return MaterialPageRoute(builder: (_) => SplashPage());
      case '/feedback_list':
        return MaterialPageRoute(builder: (_) => FeedbackListPage());
      case '/web_view':
        //跳转 web view, 解析对应参数。
        Map map = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
            builder: (_) => WebViewPage(map["url"], map["path"]));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }

  ///一般跳转，无参数
  static Future<dynamic> navigateTo(String routeName, {Object? arg}) {
    return App.navState.currentState!.pushNamed(routeName, arguments: arg);
  }

  ///跳转  WebView, 带参数的页面建议单独定义
  static Future<dynamic> navWebView(String url, {String? path}) {
    return navigateTo('/web_view', arg: {"url": url, "path": path ?? ""});
  }
}
