import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/common/AppContext.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:hatchery/manager/splash_manager.dart';
import 'package:hatchery/manager/app_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashManager _splashManager = App.manager<SplashManager>();
  AppManager _appManager = App.manager<AppManager>();

  @override
  void initState() {
    _appManager.init();
    _splashManager.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Selector<SplashManager, Advertising?>(
        builder: (BuildContext context, Advertising? value, Widget? child) {
          if (value == null) {
            return _fullScreenBackgroundView();
          } else {
            // UmengCommonSdk.onPageStart("splashView");
            return _adView(value);
          }
        },
        selector: (BuildContext context, SplashManager splashManager) {
          return splashManager.advertising;
        },
        shouldRebuild: (pre, next) => (pre != next),
      ),
    );
  }

  Widget _adView(Advertising advertising) {
    print('DEBUG=> _adView 重绘了。。。。。。。。。。');
    return CachedNetworkImage(
      imageUrl: advertising.image,
      imageBuilder: (context, imageProvider) {
        print('DEBUG=> imageProvider ${advertising.image}');
        _splashManager.stopAllTimer();
        _splashManager.splashCountDownTime();
        return Stack(children: [
          GestureDetector(
            onTap: () => _splashManager.clickAD(),
            child: Container(
              width: Flavors.sizesInfo.screenWidth,
              height: Flavors.sizesInfo.screenHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Selector<SplashManager, int?>(
            builder: (BuildContext context, int? value, Widget? child) {
              return Positioned(
                top: 50.0,
                right: 20.0,
                //控件透明度 0.0完全透明，1.0完全不透明
                child: Opacity(
                  opacity: 0.5,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black)),
                      child: Container(
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("$value  ",
                                style: Flavors.textStyles.splashFont),
                            Container(
                              color: Colors.white,
                              height: 15.0.h,
                              width: 1.0.w,
                            ),
                            Text("  跳过", style: Flavors.textStyles.splashFont),
                          ],
                        ),
                      ),
                      onPressed: () => _splashManager.skip()),
                ),
              );
            },
            selector: (BuildContext context, SplashManager splashManager) {
              return splashManager.countDown;
            },
            shouldRebuild: (pre, next) => (pre != next),
          ),
        ]);
      },
      filterQuality: FilterQuality.medium,
      fadeOutDuration: const Duration(milliseconds: 300),
      fadeInDuration: const Duration(milliseconds: 300),
      fit: BoxFit.cover,
      placeholder: (context, url) => _fullScreenBackgroundView(),
    );
  }

  // Widget _skipBtnView(manager) {
  //   return Countdown(
  //     seconds: Flavors.timeConfig.SPLASH_TIME,
  //     build: (BuildContext context, double time) {
  //       manager.timer?.cancel();
  //       return Text("跳过  ${time.toInt()}",
  //           style: Flavors.textStyles.splashFont);
  //     },
  //     interval: Duration(seconds: 1),
  //     onFinished: () {
  //       manager.routeHomePage();
  //     },
  //   );
  // }

  Widget _fullScreenBackgroundView() {
    print('DEBUG=> _fullScreenBackgroundView 重绘了。。。。。。。。。。');
    return Stack(
      children: [
        Container(
          child: Image.asset(
            'images/splash.jpg',
            width: Flavors.sizesInfo.screenWidth,
            height: Flavors.sizesInfo.screenHeight,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 120),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Text(
                Flavors.stringsInfo.community_name,
                style: TextStyle(
                  color: Colors.white70,
                  fontStyle: FontStyle.normal,
                  fontSize: 40,
                  decoration: TextDecoration.none,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 5.0,
                      color: Color.fromARGB(100, 0, 0, 0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Text(
                Flavors.stringsInfo.community_info,
                style: TextStyle(
                  color: Colors.white70,
                  fontStyle: FontStyle.normal,
                  fontSize: 26,
                  decoration: TextDecoration.none,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
