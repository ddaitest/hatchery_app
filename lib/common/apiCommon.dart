import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:hatchery/configs.dart';
import 'package:hatchery/common/utils.dart';

Future apiResponseCheck(res) async {
  Map<String, dynamic> _result = {};
  Response response = await res;
  if (response.statusCode == 200) {
    _result = response.data ?? null;
    print("DEBUG=> ${_result['code']}");
    if (_result['message'] == 'success' &&
        _result['code'] == RESPONSE_STATUS_CODE) {
      print("DEBUG=> ${_result['data']}");
      return _result['data'] ?? null;
    } else {
      showToast('服务异常，请稍后再试');
      return null;
    }
  } else {
    showToast('服务异常，请稍后重试');
    return '';
  }
}
