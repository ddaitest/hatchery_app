import 'package:flutter/material.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:hatchery/manager/app_manager.dart';
import 'package:provider/provider.dart';
import 'business/splash/splash.dart';
import 'business/home/home.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(builder: (context) => AppManager()),
    ],
    child: MyApp(),
  ));
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
