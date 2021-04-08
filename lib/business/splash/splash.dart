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
    return ChangeNotifierProvider(
      create: (context) => _splashManager,
      child: _splashPage(context, _splashManager),
    );
  }

  _splashPage(BuildContext context, manager) {
    return Selector(
      builder: (BuildContext context, bool? value, _) {
        if (value == null) {
          return _fullScreenBackgroundView();
        } else if (value) {
          // UmengCommonSdk.onPageStart("splashView");
          return _adView(context, manager);
        } else {
          return _agreementMainView(context, manager);
        }
      },
      selector: (BuildContext context, SplashManager splashManager) {
        return splashManager.isAgreeAgreementValue;
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
            onTap: () => manager.clickAD(context),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: CachedNetworkImage(
                imageUrl:
                    'https://uploadfile.bizhizu.cn/up/34/e6/cb/34e6cb8e4ca59ec610cf7d3fb0535e8a.jpg.source.jpg',
                fit: BoxFit.cover,
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

  Widget _agreementMainView(context, manager) {
    print('DEBUG=> _agreementMainView 重绘了。。。。。。。。。。');
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                "images/welcome.png",
              ))),
      child: _agreementDialogView(context, manager),
    );
  }

  Widget _agreementDialogView(BuildContext context, manager) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(26.0, 20.0, 26.0, 24.0),
      title: Text(
        "服务条款和用户协议提示",
        style: AgreementPageTextStyle().mainTitle,
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              Agreement_text,
              style: AgreementPageTextStyle().agreementText,
              textAlign: TextAlign.start,
            ),
            Container(height: 10.0.h),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => manager.agreementUrl(context),
                    child: Text("《用户协议》",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue)),
                  ),
                  GestureDetector(
                    onTap: () => manager.agreementUrl(context),
                    child: Text("《隐私政策》",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue)),
                  ),
                ],
              ),
            ),
            Container(height: 20.0.h),
            Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 45.0.h,
                  child: ElevatedButton(
                    child: Text(
                      "确 定",
                      style: AgreementPageTextStyle().confirmBtn,
                    ),
                    onPressed: () => manager.agree(context),
                  ),
                ),
                Container(height: 10.0.h),
                GestureDetector(
                  onTap: () {
                    manager.exitApp();
                  },
                  child: Text(
                    "不同意并退出App",
                    style: AgreementPageTextStyle().closeAppBtn,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
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
