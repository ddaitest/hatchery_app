import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hatchery/business/splash/splash.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatchery/routers.dart';
import 'business/main_tab.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import 'package:hatchery/manager/app_manager.dart';

import 'routers.dart';

void main() async {
  runApp(
    ChangeNotifierProvider<AppManager>(
      create: (_) => AppManager(),
      child: Consumer<AppManager>(
        builder: (context, manager, child) => MyApp(),
      ), //添加全局Manager
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        allowFontScaling: true,
        builder: () => MaterialApp(
                title: Flavors.strings.title,
                initialRoute: '/splash',
                routes: {
                  '/': (_) => MainTab(),
                  '/splash': (_) => SplashPage(),
                }));
  }
}
