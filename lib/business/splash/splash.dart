import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/business/home/home.dart';
import 'package:hatchery/manager/splash_manager.dart';
import 'package:provider/provider.dart';

import '../../configs.dart';

class SplashPage extends StatelessWidget {
  static const length = 3;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => SplashManager(),
      child: _splashPage(context),
    );
  }

  void _gotoHomePage(BuildContext context) => Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => HomePage()));

  _splashPage(BuildContext context) {
    Timer(const Duration(seconds: SPLASH_TIME), () {
      _gotoHomePage(context);
    });
    return Consumer<SplashManager>(
      builder: (context, manager, child) => Container(
        constraints: BoxConstraints.expand(
          width: double.infinity,
          height: double.infinity,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage(manager.splashUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
