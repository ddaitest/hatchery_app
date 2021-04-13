import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hatchery/business/splash/splash.dart';
import 'package:hatchery/business/splash/agreementPage.dart';
import 'package:hatchery/common/AppContext.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hatchery/manager/feedback_manager.dart';
import 'package:hatchery/routers.dart';
import 'configs.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:hatchery/common/tools.dart';
import 'package:provider/provider.dart';
import 'package:hatchery/manager/app_manager.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'manager/contact_manager.dart';
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
                ChangeNotifierProvider(create: (_) => ContactManager()),
                ChangeNotifierProvider(create: (_) => FeedbackManager()),
              ],
              child: MyApp(),
            ),
          );
        }),
      );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppManager manager = Provider.of<AppManager>(context, listen: false);
    print("DEBUG LC => ${manager.isAgreeAgreementValue}");
    return ScreenUtilInit(
        builder: () => MaterialApp(
              title: Flavors.stringsInfo.community_name,
              navigatorKey: App.navState,
              initialRoute:
                  manager.isAgreeAgreementValue ? '/splash' : '/agreementPage',
              onGenerateRoute: Routers.generateRoute,
              theme: ThemeData(
                textTheme: GoogleFonts.notoSansTextTheme(),
                // Define the default brightness and colors.
                brightness: Brightness.light,
                primaryColor: Colors.lightBlue[800],
                accentColor: Colors.cyan[600],
                // primaryIconTheme: IconThemeData().color = Colors.blue
                iconTheme: IconThemeData(
                  color: Colors.black87, //change your color here
                ),
                primaryIconTheme: IconThemeData(
                  color: Colors.black87, //change your color here
                ),
              ),
            ));
  }
}
