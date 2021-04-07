import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hatchery/business/splash/splash.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatchery/routers.dart';
import 'configs.dart';
import 'business/main_tab.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:provider/provider.dart';
import 'package:hatchery/manager/app_manager.dart';

import 'routers.dart';

void main() async {
  FlutterBugly.postCatchedException(() {
    runApp(
      ChangeNotifierProvider<AppManager>(
        create: (_) => AppManager(),
        child: Consumer<AppManager>(
          builder: (context, manager, child) => MyApp(),
        ), //添加全局Manager
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        allowFontScaling: true,
        builder: () => MaterialApp(
                title: COMMUNITY_NAME,
                initialRoute: '/splash',
                routes: {
                  '/': (_) => MainTab(),
                  '/splash': (_) => SplashPage(),
                }));
  }
}
