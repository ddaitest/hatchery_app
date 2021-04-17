
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/common/AppContext.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:hatchery/manager/splash_manager.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    App.manager<SplashManager>().init();
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
      ),
    );
  }

  Widget _adView(Advertising advertising) {
    print('DEBUG=> _adView 重绘了。。。。。。。。。。');
    var manager = App.manager<SplashManager>();
    return CachedNetworkImage(
      imageUrl: advertising.image,
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
                child: Selector<SplashManager, int?>(
                  builder: (BuildContext context, int? value, Widget? child) {
                    return ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        child: Text("跳过  $value",
                            style: Flavors.textStyles.splashFont),
                        onPressed: manager.skip);
                  },
                  selector:
                      (BuildContext context, SplashManager splashManager) {
                    return splashManager.countDown;
                  },
                ),
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
