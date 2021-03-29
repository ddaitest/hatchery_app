import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:hatchery/routers.dart';
import 'business/splash/splash.dart';
import 'business/splash/agreement.dart';
import 'business/home/home.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:hatchery/common/tools.dart';
import 'package:hatchery/configs.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_jpush/flutter_jpush.dart';
import 'package:provider/provider.dart';
import 'package:hatchery/manager/app_manager.dart';

bool _agreementDataKey = true;

void main() async {
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
    return MaterialApp(
        title: Flavors.strings.title,
        initialRoute: '/splash',
        routes: {
          '/': (_) => HomePage(),
          '/splash': (_) => SplashPage(),
        });
  }
}

//class MyApp extends StatefulWidget {
//  @override
//  _MyAppState createState() => _MyAppState();
//}
//
//class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
//  @override
//  void initState() {
//    super.initState();
//    WidgetsBinding.instance.addObserver(this);
//  }

//  @override
//  void didChangeAppLifecycleState(AppLifecycleState state) {
//    switch (state) {
//      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
//        print("LC -> ################# inactive");
//        break;
//      case AppLifecycleState.resumed: // 应用程序可见，前台
//        print("LC -> ################# resumed");
//        break;
//      case AppLifecycleState.paused: // 应用程序不可见，后台
//        print("LC -> ################# paused");
//        break;
////      case AppLifecycleState.suspending: // 申请将暂时暂停
////        print("LC -> ################# suspending");
////        break;
//      case AppLifecycleState.detached:
//        print("LC -> ################# detached");
//        break;
//    }
//  }

// This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: Flavors.strings.title,
//      theme: ThemeData(primarySwatch: Colors.blue),
//      home: SplashPage(),
//      routes: {
//        '/home': (context) => HomePage(),
//      },
//    );
//  }
//
//  @override
//  void dispose() {
//    WidgetsBinding.instance.removeObserver(this);
//    super.dispose();
//  }
//}

void _startupJpush() async {
  print("初始化jpush...");
  await FlutterJPush.startup();
  print("初始化jpush成功!");
}
