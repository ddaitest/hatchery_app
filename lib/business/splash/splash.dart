import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/business/home/home.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../configs.dart';

class SplashPage extends StatelessWidget {
  static const length = 3;
  final pageIndexNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return _splashPage("images/welcome.png", "test", context);
  }

  void _gotoHomePage(BuildContext context) => Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => HomePage()));

  _splashPage(String image, String action, BuildContext context) {
    Timer(const Duration(seconds: SPLASH_TIME), () {
      _gotoHomePage(context);
    });
    return Container(
      constraints: BoxConstraints.expand(
        width: double.infinity,
        height: double.infinity,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: ExactAssetImage('images/welcome.png'), fit: BoxFit.cover),
      ),
    );
  }

  final TextStyle splashFont = const TextStyle(
      fontSize: 27.0,
      height: 1.5,
      fontWeight: FontWeight.w500,
      color: Colors.white);
  final TextStyle splashFontNow = const TextStyle(
      fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.black);
}
