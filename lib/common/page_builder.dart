import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'bundle.dart';

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