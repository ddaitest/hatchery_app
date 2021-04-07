import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/manager/beans.dart';
import 'dart:collection';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:hatchery/common/api.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:hatchery/common/tools.dart';
import 'package:hatchery/configs.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

class AppManager extends ChangeNotifier {
  int _m = 0;

  int get m => _m;

  bool _agreementDataKey = false;
  bool get agreementDataKey => _agreementDataKey;

  List<Contact> _phoneNumbersList = [];

  UnmodifiableListView<Contact> get phoneNumbersList =>
      UnmodifiableListView(_phoneNumbersList);

  int get total => _phoneNumbersList.length;

  int timeNow = DateTime.now().millisecondsSinceEpoch;

  final JPush jpush = JPush();

  AppManager() {
    ///todo 先关闭
    // FlutterBugly.init(androidAppId: "41d23c0115", iOSAppId: "7274afdfed");
    // initPlatformState();
    SP().init();
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

  showToast(String title) {
    Fluttertoast.showToast(
        msg: title,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0x99000000),
        textColor: Colors.white,
        fontSize: 15.0);
  }

  copyData(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  callPhoneNum(String number) async {
    if (await canLaunch("tel:${number}")) {
      await launch("tel:${number}");
    } else {
      throw 'Could not launch $number';
    }
  }

  shareFrame(String contents) {
    Share.share(contents);
  }

//   queryPhoneNumData() async {
//     Response response = await Api.queryPhoneNumList();
//     if (response.data != null) {
//       final parsed = json.decode(response.data)['numberlist'] ?? null;
// //      var resultCode = parsed['code'] ?? 0;
//       for (var x in parsed) {
//         add(PhoneNumberInfo.fromJson(x));
//       }
// //      print("LC->#### ${_phoneNumbersList}");
//     }
//   }

  // void add(PhoneNumberInfo item) {
  //   _phoneNumbersList.add(item);
  //   notifyListeners();
  // }

  @override
  void dispose() {
    FlutterBugly.dispose();
    super.dispose();
  }
}
