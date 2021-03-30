import 'package:fluro/fluro.dart';

import 'business/main_tab.dart';
import 'business/home/phone_numbers.dart';
import 'business/home/report_something.dart';
import 'business/splash/splash.dart';
import 'common/page_builder.dart';

class Routers {
  final router = FluroRouter();

  static final Map<String, PageBuilder> pageRouters = {
    '/splash': PageBuilder((bundle) => SplashPage()),
    '/': PageBuilder((bundle) => MainTab()),
    '/service1': PageBuilder((bundle) => ReportSomethingPage()),
    '/service2': PageBuilder((bundle) => PhoneNumbersPage()),
//    '/home': PageBuilder((bundle) => Second(bundle: bundle)),
  };

  static void setupRouter(FluroRouter router) {
    pageRouters.forEach((k, h) {
      router.define(k, handler: h.getHandler());
    });
  }
}
