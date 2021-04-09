import 'package:flutter/material.dart';
import 'package:hatchery/manager/splash_manager.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hatchery/configs.dart';
import 'package:hatchery/common/theme.dart';
import 'package:timer_count_down/timer_count_down.dart';
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
    if (manager.splashAdLists!.isEmpty) {
      return _fullScreenBackgroundView();
    } else {
      // UmengCommonSdk.onPageStart("splashView");
      return _adView(context, manager);
    }
  }

  Widget _adView(context, manager) {
    print('DEBUG=> _adView 重绘了。。。。。。。。。。');
    return CachedNetworkImage(
      imageUrl: manager.splashAdLists[0].image,
      imageBuilder: (context, imageProvider) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () => manager.clickAD(context),
              child: Container(
                width: double.infinity.w,
                height: double.infinity.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
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
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    // color: Colors.black,
                    // splashColor: Colors.black,
                    child: _skipBtnView(context, manager),
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

  Widget _skipBtnView(context, manager) {
    return Countdown(
      seconds: SPLASH_TIME,
      build: (BuildContext context, double time) => Text("跳过  ${time.toInt()}"),
      interval: Duration(seconds: 1),
      onFinished: () {
        manager.routeHomePage(context);
      },
    );
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
