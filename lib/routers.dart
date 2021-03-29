import 'package:fluro/fluro.dart';

import 'business/home/home.dart';
import 'business/splash/splash.dart';
import 'common/page_builder.dart';

class Routers {
  final router = FluroRouter();

  static final Map<String, PageBuilder> pageRouters = {
    '/splash': PageBuilder((bundle) => SplashPage()),
    '/': PageBuilder((bundle) => HomePage()),
//    '/home': PageBuilder((bundle) => Second(bundle: bundle)),
  };

  static void setupRouter(FluroRouter router) {
    pageRouters.forEach((k, h) {
      router.define(k, handler: h.getHandler());
    });
  }
}
