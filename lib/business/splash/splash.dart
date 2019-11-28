import 'package:flutter/material.dart';
import 'package:hatchery/business/home/home.dart';
import 'package:hatchery/manager/splash_manager.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hatchery/common/widget/webview_common.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<SplashPage> {
  //页面初始化状态的方法
//  @override
//  void initState() {
//    super.initState();
//  }

  void gotoHomePage(BuildContext bc) async {
    Future.microtask(() => Navigator.pushReplacement(
        bc, MaterialPageRoute(builder: (bc) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => SplashManager(),
      child: _splashPage(context),
    );
  }

  _splashPage(BuildContext context) {
    return Consumer<SplashManager>(
      builder: (context, manager, child) => Container(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebViewPage(manager.splashGoto)),
                );
                manager.timer.cancel();
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: manager.splashUrl,
                  fit: BoxFit.cover,
                ),
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
                  child: Consumer<SplashManager>(builder: (cdt, manager, cd) {
                    if (manager.countdownTime == 1) {
                      gotoHomePage(context);
                    }
                    return Text("跳过 ${manager.countdownTime}");
                  }),
                  onPressed: () {
                    gotoHomePage(context);
                    manager.timer.cancel();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
