import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'business/home/home.dart';
import 'business/splash/splash.dart';
import 'common/bundle.dart';

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

typedef Widget HandleFunc(
    BuildContext context, Map<String, List<String>> params);
typedef Widget PageFunc(Bundle bundle);

class PageBuilder {
  final PageFunc builder;
  HandleFunc handleFunc;

  PageBuilder(this.builder) {
    this.handleFunc = (context, p) {
      return this.builder(ModalRoute.of(context).settings.arguments as Bundle);
    };
  }

  Handler getHandler() {
    return Handler(handlerFunc: this.handleFunc);
  }
}
