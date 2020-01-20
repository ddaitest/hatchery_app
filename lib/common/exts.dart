import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

extension ExtendedResponse on Response {
  bool success() {
    if (this.data == null) {
      return false;
    }
    var json = jsonDecode(this.data);
    return (json['code'] == 200 && json['info'] == 'OK');
  }

  getResult() {
    if (this.data == null) {
      return null;
    }
    var json = jsonDecode(this.data);
    if (json['code'] == 200 && json['info'] == 'OK') {
      return json['result'];
    } else {
      return null;
    }
  }
}

extension ExtendedWidget on Widget{
  addSilver(){
    return SliverToBoxAdapter(child:this);
  }
}
