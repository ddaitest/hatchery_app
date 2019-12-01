import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:hatchery/common/api.dart';
import 'package:hatchery/manager/beans.dart';
import 'package:flutter/material.dart';

class HomeManager extends ChangeNotifier {
  ///服务tab顶部
  var ServiceTopMap = {
    "0": "物业服务",
    "1": "家电维修",
    "2": "保姆月嫂",
    "3": "洗车",
    "4": "便民服务",
    "5": "房屋租售",
    "6": "各种服务",
    "7": "其他",
  };

  @override
  void dispose() {
    super.dispose();
  }
}
