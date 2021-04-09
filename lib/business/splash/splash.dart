import 'package:flutter/material.dart';
import 'package:hatchery/manager/splash_manager.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hatchery/configs.dart';
import 'package:hatchery/common/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:launch_review/launch_review.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SplashManager _splashManager = SplashManager(context);
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => _splashManager,
        child: _splashPage(context, _splashManager),
      ),
    );
  }

  _splashPage(BuildContext context, manager) {
    return Selector(
      builder: (BuildContext context, List? value, _) {
        if (value!.length == 0) {
          return _fullScreenBackgroundView();
        } else {
          // UmengCommonSdk.onPageStart("splashView");
          return _adView(context, manager);
        }
      },
      selector: (BuildContext context, SplashManager splashManager) {
        return splashManager.splashAdLists;
      },
    );
  }

  Widget _adView(context, manager) {
    print('DEBUG=> _adView 重绘了。。。。。。。。。。');
    return Container(
      constraints: BoxConstraints.expand(),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              manager.clickAD(context);
            },
            child: Container(
              width: double.infinity.w,
              height: double.infinity.h,
              child: CachedNetworkImage(
                imageUrl: manager.splashAdLists[0].image,
                fit: BoxFit.cover,
                placeholder: (context, url) => _fullScreenBackgroundView(),
              ),
            ),
          ),
          Positioned(
            width: 75.0.w,
            top: 50.0,
            right: 20.0,
            //控件透明度 0.0完全透明，1.0完全不透明
            child: Opacity(
              opacity: 0.5,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  // color: Colors.black,
                  // splashColor: Colors.black,
                  child: _skipBtnView(),
                  onPressed: () {
                    manager.skip(context);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _skipBtnView() {
    return Selector(builder: (BuildContext context, int value, Widget? child) {
      print('DEBUG=> countdownTime 重绘了。。。。。。。。。。');
      return Text("跳过 ${value.toString()}");
    }, selector: (BuildContext context, SplashManager splashManager) {
      //这个地方返回具体的值，对应builder中的value
      return splashManager.countdownTime;
    });
  }

  Widget _fullScreenBackgroundView() {
    print('DEBUG=> _fullScreenBackgroundView 重绘了。。。。。。。。。。');
    return Container(
      child: Image.asset(
        'images/welcome.png',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
