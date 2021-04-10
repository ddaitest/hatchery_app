import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hatchery/business/splash/splash.dart';
import 'package:hatchery/business/splash/agreementPage.dart';
import 'package:hatchery/common/AppContext.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'configs.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'business/main_tab.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:hatchery/common/tools.dart';
import 'package:provider/provider.dart';
import 'package:hatchery/manager/app_manager.dart';

import 'manager/home_manager.dart';
import 'manager/nearby_manager.dart';
import 'manager/service_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SP.init().then(
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
            MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => AppManager()),
                ChangeNotifierProvider(create: (_) => HomeManager()),
                ChangeNotifierProvider(create: (_) => NearbyManager()),
                ChangeNotifierProvider(create: (_) => ServiceManager()),
              ],
              child: MyApp(),
            ),
          );
        }),
      );
}

class MyApp extends StatelessWidget {
  MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppManager manager = Provider.of<AppManager>(context, listen: false);
    return ScreenUtilInit(
        builder: () => MaterialApp(
            title: COMMUNITY_NAME,
            navigatorKey: AppContext.navState,
            initialRoute:
                manager.isAgreeAgreementValue ? '/agreementPage' : '/splash',
            routes: {
              '/': (_) => MainTab(),
              '/agreementPage': (_) => AgreementPage(),
              '/splash': (_) => SplashPage(),
            }));
  }
}
