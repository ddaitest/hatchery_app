import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/business/home/home.dart';
import 'package:hatchery/manager/splash_manager.dart';
import 'package:provider/provider.dart';

import '../../configs.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<SplashPage> {
  Timer _timer;

  //倒计时数值
  var countdownTime = 0;

  //页面初始化状态的方法
  @override
  void initState() {
    super.initState();
    //开启倒计时
    startCountdown();
  }

  //倒计时方法
  startCountdown() {
    countdownTime = SPLASH_TIME;
    final call = (timer) {
      setState(() {
        print("###### $countdownTime");
        if (countdownTime <= 1) {
          _timer.cancel();
        } else {
          countdownTime -= 1;
        }
      });
    };
    _timer = Timer.periodic(Duration(seconds: 1), call);
  }

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
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                manager.splashUrl,
                fit: BoxFit.cover,
              ),
            ),
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
                  child: Text("跳过 $countdownTime"),
                  onPressed: () {
                    _gotoHomePage(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
