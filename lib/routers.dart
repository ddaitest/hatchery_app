import 'package:fluro/fluro.dart';

import 'business/home/home.dart';
import 'business/splash/splash.dart';
import 'common/page_builder.dart';

class Routers {
  static Router router = Router();

  static final Map<String, PageBuilder> pageRouters = {
    '/splash': PageBuilder((bundle) => SplashPage()),
    '/': PageBuilder((bundle) => HomePage()),
//    '/home': PageBuilder((bundle) => Second(bundle: bundle)),
  };

  static void setupRouter() {
    pageRouters.forEach((k, h) {
      router.define(k, handler: h.getHandler());
    });
  }
}


