import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/common/AppContext.dart';
import 'package:hatchery/common/route_animation.dart';
import 'business/contact/contact_page.dart';
import 'business/feedback/feedback_list.dart';
import 'business/feedback/feedback_new.dart';
import 'business/list/list_page.dart';
import 'business/main_tab.dart';
import 'business/splash/agreementPage.dart';
import 'business/splash/splash.dart';
import 'common/widget/webview_common.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(builder: (_) => MainTab());
      case '/agreementPage':
        return CupertinoPageRoute(builder: (_) => AgreementPage());
      case '/splash':
        return CupertinoPageRoute(builder: (_) => SplashPage());
      case '/feedback_list':
        return CupertinoPageRoute(builder: (_) => FeedbackListPage());
      case '/feedback_new':
        return CupertinoPageRoute(builder: (_) => FeedbackNew());
      case '/contact':
        return CupertinoPageRoute(builder: (_) => ContactPage());
      case '/repairs_list':
        return CupertinoPageRoute(builder: (_) => FeedbackListPage());
      case '/repairs_new':
        return CupertinoPageRoute(builder: (_) => FeedbackNew());
      // case '/contact':
      //   return MaterialPageRoute(builder: (_) => ContactPage());
      // case '/contact':
      //   return MaterialPageRoute(builder: (_) => ContactPage());

      case '/list_page':
        return CupertinoPageRoute(
            builder: (_) => ListPage(settings.arguments as String));
      case '/web_view':
        //跳转 web view, 解析对应参数。
        Map map = settings.arguments as Map<String, String>;
        return CupertinoPageRoute(
            builder: (_) => WebViewPage(map["url"], map["path"]));
      default:
        return CupertinoPageRoute(
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

  ///跳转  WebView, 带参数的页面建议单独定义
  static Future<dynamic> navListPage(String serviceId) {
    return navigateTo('/list_page', arg: serviceId);
  }
}
