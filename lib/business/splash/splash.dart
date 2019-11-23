import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hatchery/business/home/home.dart';
import 'package:hatchery/manager/splash_manager.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => SplashManager(),
      child: _splashPage(context),
    );
  }

  void _gotoHomePage2(BuildContext bc) async {
    Future.microtask(() => Navigator.pushReplacement(
        bc, MaterialPageRoute(builder: (bc) => HomePage())));
  }

  _splashPage(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Stack(
        children: <Widget>[
          Container(
              width: double.infinity,
              height: double.infinity,
              child: Consumer<SplashManager>(
                  builder: (context, manager, child) =>
                      Image.asset(manager.splashUrl, fit: BoxFit.cover))),
          Positioned(
            width: 75.0,
            top: 50.0,
            right: 20.0,
            //控件透明度 0.0完全透明，1.0完全不透明
            child: Opacity(
              opacity: 0.4,
              child: FlatButton(
                color: Colors.black,
                colorBrightness: Brightness.dark,
                splashColor: Colors.black,
                child: Consumer<SplashManager>(builder: (ct, manager, c) {
                  if (manager.countdown<1){
                    _gotoHomePage2(ct);
                  }
                  return Text("跳过 ${manager.countdown}");
                }),
                onPressed: () => _gotoHomePage2(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
