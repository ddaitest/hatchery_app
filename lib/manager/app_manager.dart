import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hatchery/api/entity.dart';
import 'dart:collection';
import 'package:hatchery/flavors/Flavors.dart';
import 'package:flutter/services.dart';
import 'package:hatchery/common/backgroundListenModel.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:hatchery/common/tools.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

import '../config.dart';

class AppManager extends ChangeNotifier {
  List<Contact> phoneNumbersList = [];

  // UnmodifiableListView<Contact> get phoneNumbersList =>
  //     UnmodifiableListView(_phoneNumbersList);

  // int get total => _phoneNumbersList.length;

  DateTime now = DateTime.now();

  final JPush jpush = JPush();

  /// 后台监听初始化
  init() {
    BackgroundListen().init();
  }

  AppManager() {
    SP.init().then((sp) {
      DeviceInfo.init();
      UserId.init();
    });
    initPlatformState();
    buglyInit();
  }

  Future<void> initPlatformState() async {
    try {
      jpush.addEventHandler(
          onReceiveNotification: (Map<String, dynamic> message) async {
        print("flutter onReceiveNotification: $message");
      }, onOpenNotification: (Map<String, dynamic> message) async {
        print("flutter onOpenNotification: $message");
      }, onReceiveMessage: (Map<String, dynamic> message) async {
        print("flutter onReceiveMessage: $message");
      }, onReceiveNotificationAuthorization:
              (Map<String, dynamic> message) async {
        print("flutter onReceiveNotificationAuthorization: $message");
      });
    } on PlatformException {
      return;
    }

    jpush.setup(
      appKey: "a1f964ef7fa9723b1a328fec", //你自己应用的 AppKey
      channel: "theChannel",
      production: false,
      debug: false,
    );
    jpush.applyPushAuthority(
        new NotificationSettingsIOS(sound: true, alert: true, badge: true));

    // Platform messages may fail, so we use a try/catch PlatformException.
    jpush.getRegistrationID().then((rid) {
      print("flutter get registration id : $rid");
    });
  }

  void buglyInit() {
    FlutterBugly.init(
      androidAppId: "41d23c0115",
      iOSAppId: "7274afdfed",
      autoInit: true,
      autoCheckUpgrade: true,
    );
  }

  @override
  void dispose() {
    FlutterBugly.dispose();
    super.dispose();
  }
}
