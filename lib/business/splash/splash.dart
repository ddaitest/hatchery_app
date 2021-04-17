import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:collection';
import 'package:hatchery/manager/splash_manager.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:hatchery/api/entity.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:launch_review/launch_review.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SplashManager splashManager = SplashManager();
    return Material(
      child: ChangeNotifierProvider(
        create: (context) => SplashManager(),
        child: Selector<SplashManager, List<Advertising>>(
          builder:
              (BuildContext context, List<Advertising> value, Widget? child) {
            if (value.isEmpty) {
              return _fullScreenBackgroundView();
            } else {
              // UmengCommonSdk.onPageStart("splashView");
              return _adView(splashManager);
            }
          },
          selector: (BuildContext context, SplashManager splashManager) {
            return splashManager.splashAdLists;
          },
          shouldRebuild: (pre, next) => pre != next,
        ),
      ),
    );
  }

  Widget _adView(manager) {
    print('DEBUG=> _adView 重绘了。。。。。。。。。。');
    return CachedNetworkImage(
      imageUrl: manager.splashAdLists[0].image,
      imageBuilder: (context, imageProvider) {
        print('DEBUG=> imageProvider $imageProvider');
        return Stack(
          children: [
            GestureDetector(
              onTap: () => manager.clickAD(),
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
            Positioned(
              top: 50.0,
              right: 20.0,
              //控件透明度 0.0完全透明，1.0完全不透明
              child: Opacity(
                opacity: 0.5,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    // color: Colors.black,
                    // splashColor: Colors.black,
                    child: _skipBtnView(manager),
                    onPressed: () {
                      manager.skip(context);
                    }),
              ),
            ),
          ],
        );
      },
      filterQuality: FilterQuality.medium,
      fadeOutDuration: const Duration(milliseconds: 300),
      fadeInDuration: const Duration(milliseconds: 300),
      fit: BoxFit.cover,
      placeholder: (context, url) => _fullScreenBackgroundView(),
    );
  }

  Widget _skipBtnView(manager) {
    return Countdown(
      seconds: Flavors.timeConfig.SPLASH_TIME,
      build: (BuildContext context, double time) {
        manager.timer?.cancel();
        return Text("跳过  ${time.toInt()}",
            style: Flavors.textStyles.splashFont);
      },
      interval: Duration(seconds: 1),
      onFinished: () {
        manager.routeHomePage();
      },
    );
  }

  Widget _fullScreenBackgroundView() {
    print('DEBUG=> _fullScreenBackgroundView 重绘了。。。。。。。。。。');
    return Container(
      child: Image.asset(
        'images/splash.jpg',
        width: Flavors.sizesInfo.screenWidth,
        height: Flavors.sizesInfo.screenHeight,
        fit: BoxFit.cover,
      ),
    );
  }
}
