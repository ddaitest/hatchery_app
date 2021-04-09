import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hatchery/business/splash/splash.dart';
import 'package:hatchery/business/splash/agreementPage.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'configs.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'business/main_tab.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:hatchery/common/tools.dart';
import 'package:provider/provider.dart';
import 'package:hatchery/manager/app_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SP().init().then(
        (value) => FlutterBugly.postCatchedException(() {
          if (Platform.isAndroid) {
            SystemUiOverlayStyle style = SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,

                ///这是设置状态栏的图标和字体的颜色
                ///Brightness.light  一般都是显示为白色
                ///Brightness.dark 一般都是显示为黑色
                statusBarIconBrightness: Brightness.dark);
            SystemChrome.setSystemUIOverlayStyle(style);
          }
          runApp(
            ChangeNotifierProvider<AppManager>(
              create: (_) => AppManager(),
              child: Consumer<AppManager>(
                builder: (context, manager, child) => MyApp(manager),
              ), //添加全局Manager
            ),
          );
        }),
      );
}

class MyApp extends StatelessWidget {
  final AppManager appManager;
  MyApp(this.appManager);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        allowFontScaling: true,
        builder: () => MaterialApp(
                title: COMMUNITY_NAME,
                initialRoute: appManager.isAgreeAgreementValue!
                    ? '/splash'
                    : '/agreementPage',
                routes: {
                  '/': (_) => MainTab(),
                  '/agreementPage': (_) => AgreementPage(),
                  '/splash': (_) => SplashPage(),
                }));
  }
}
