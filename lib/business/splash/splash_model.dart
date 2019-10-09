import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SplashModel extends Model {
  static SplashModel of(BuildContext context) =>
      ScopedModel.of<SplashModel>(context, rebuildOnChange: true);

  String _splashUrl = 'images/welcome.png';

  String get splashUrl => _splashUrl;

  String _splashTip = "泰达希尔\n暴风城\n";

  String get splashTip => _splashTip;
}
