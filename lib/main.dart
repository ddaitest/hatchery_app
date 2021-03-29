import 'package:flutter/material.dart';
import 'package:hatchery/business/splash/splash.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatchery/routers.dart';
import 'business/home/home.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_jpush/flutter_jpush.dart';
import 'package:provider/provider.dart';
import 'package:hatchery/manager/app_manager.dart';

import 'routers.dart';

void main() async {
  final router = FluroRouter();
//  FlutterBugly.postCatchedException(() {
//    runApp(MyApp());
//  });
//
//  FlutterBugly.init(
//    androidAppId: "41d23c0115",
//    iOSAppId: "7274afdfed",
//  );
//  _startupJpush();
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
                  '/': (_) => HomePage(),
                  '/splash': (_) => SplashPage(),
                }));
  }
}

void _startupJpush() async {
  print("初始化jpush...");
  await FlutterJPush.startup();
  print("初始化jpush成功!");
}
