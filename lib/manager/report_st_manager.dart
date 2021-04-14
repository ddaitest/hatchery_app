import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReportStManager extends ChangeNotifier {
  String? result;
  var parsed;

  ///报事报修发送
  // Future postReportStData(inputText, contact, imgUrl) async {
  //   Response response = await ApiForReportSt.postReportData({
  //     "name": "$CLIENT_ID",
  //     "message": inputText,
  //     "contact": contact,
  //     "img_url": imgUrl
  //   });
  //   result = response.data = '';
  //   parsed = jsonDecode(result!);
  //   print('code ${parsed['code']}');
  //   if (result != null && parsed['code'] == 200 && parsed['info'] == 'OK') {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // ///报事报修图片上传
  // Future uploadReportStImage(imagePath) async {
  //   FormData formdata = FormData.fromMap({
  //     "file": await MultipartFile.fromFile(imagePath, filename: 'file.jpg')
  //   });
  //   Response response = await ApiForReportSt.uploadReportImage(formdata);
  //   result = response.data ?? '';
  //   parsed = jsonDecode(result!);
  //   print('result $parsed');
  //   if (result != null && parsed['code'] == 200 && parsed['info'] == 'OK') {
  //     return parsed['result'];
  //   } else {
  //     showToast('图片上传失败,请重试');
  //   }
  // }

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
}
