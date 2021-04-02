import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:hatchery/configs.dart';
import 'package:hatchery/common/utils.dart';

Future apiResponseCheck(res, {Map body}) async {
  String _result = '';
  Map<dynamic, dynamic> _parsed = {};
  Response response = await res;
  if (response.statusCode == 200) {
    _result = response.data ?? null;
    _parsed = json.decode(_result);
    if (_parsed['message'] == 'success' &&
        _parsed['code'] == RESPONSE_STATUS_CODE) {
      return _parsed['data'] ?? null;
    } else {
      showToast('服务异常，请稍后再试');
      return '';
    }
  } else {
    showToast('服务异常，请稍后重试');
    return '';
  }
}
