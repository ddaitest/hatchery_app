import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hatchery/manager/beans.dart';
import 'dart:collection';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:hatchery/common/api.dart';
import 'package:hatchery/common/tools.dart';
import 'package:hatchery/configs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppManager extends ChangeNotifier {
  int _m = 0;

  int get m => _m;

  bool _agreementDataKey = false;
  bool get agreementDataKey => _agreementDataKey;

  List<PhoneNumberInfo> _phoneNumbersList = [];

  UnmodifiableListView<PhoneNumberInfo> get phoneNumbersList =>
      UnmodifiableListView(_phoneNumbersList);

  int get total => _phoneNumbersList.length;

  int timeNow = DateTime.now().millisecondsSinceEpoch;

  AppManager() {
    _getAgreementData();
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

  /// 获取协议是否同意标识
  _getAgreementData() {
    sharedGetData(Agreement_DATA_KEY).then((value) {
      if (value != null) {
        _agreementDataKey = true;
      } else {
        _agreementDataKey = false;
      }
    });
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

  queryPhoneNumData() async {
    Response response = await Api.queryPhoneNumList();
    if (response.data != null) {
      final parsed = json.decode(response.data)['numberlist'] ?? null;
//      var resultCode = parsed['code'] ?? 0;
      for (var x in parsed) {
        add(PhoneNumberInfo.fromJson(x));
      }
//      print("LC->#### ${_phoneNumbersList}");
    }
  }

  void add(PhoneNumberInfo item) {
    _phoneNumbersList.add(item);
    notifyListeners();
  }
}
