import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppContext {
  static final navState = new GlobalKey<NavigatorState>();

  static T getManager<T>({bool listen: false}) {
    return Provider.of<T>(navState.currentContext!, listen: listen);
  }
}
