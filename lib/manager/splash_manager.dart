import 'package:flutter/foundation.dart';

class SplashManager extends ChangeNotifier {
  String _splashUrl = 'images/welcome.png';

  String get splashUrl => _splashUrl;

  String _splashTip = "泰达希尔\n暴风城\n";

  String get splashTip => _splashTip;
}
