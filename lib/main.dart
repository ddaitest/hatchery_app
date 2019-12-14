import 'package:flutter/material.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:hatchery/manager/app_manager.dart';
import 'package:provider/provider.dart';
import 'business/splash/splash.dart';
import 'business/home/home.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:flutter_jpush/flutter_jpush.dart';

void main() async {
  FlutterBugly.postCatchedException(() {
    runApp(MyApp());
  });

  FlutterBugly.init(
    androidAppId: "41d23c0115",
    iOSAppId: "7274afdfed",
  );
  _startupJpush();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Flavors.strings.title,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashPage(),
      routes: {
        '/home': (context) => HomePage(),
      },
    );
  }
}

void _startupJpush() async {
  print("初始化jpush...");
  await FlutterJPush.startup();
  print("初始化jpush成功!");
}
