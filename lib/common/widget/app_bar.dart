import 'package:flutter/material.dart';

class AppBarFactory {
  static AppBar getMain(String title, {List<Widget>? actions}) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
            fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      elevation: 0,
      automaticallyImplyLeading: false,
      actions: actions ?? [],
    );
  }

  static AppBar getCommon(String title) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
            fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      automaticallyImplyLeading: true,
      elevation: 0,
    );
  }
}
