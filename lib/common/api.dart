import 'dart:async';
import 'package:dio/dio.dart';

class ApiForServicePage {
  static Dio dio = Dio(BaseOptions(
      baseUrl: "https://api.apiopen.top/",
      connectTimeout: 5000,
      receiveTimeout: 3000,
      responseType: ResponseType.plain));

  static InterceptorsWrapper _interceptorsWrapper = InterceptorsWrapper(
    onRequest: (RequestOptions options) {
      return options;
    },
    onResponse: (Response response) {
      return response; // continue
    },
    onError: (DioError e) {
      return e; //continue
    },
  );

  static init() {
    if (!dio.interceptors.contains(_interceptorsWrapper)) {
      dio.interceptors.add(_interceptorsWrapper);
    }
  }

  ///周边list数据
  static queryServiceList() {
    return dio.get("musicRankings");
  }
}

class ApiForAD {
  static Dio dio = Dio(BaseOptions(
      baseUrl: "http://127.0.0.1/:5000/",
      connectTimeout: 5000,
      receiveTimeout: 3000,
      responseType: ResponseType.plain));

  static InterceptorsWrapper _interceptorsWrapper = InterceptorsWrapper(
    onRequest: (RequestOptions options) {
      return options;
    },
    onResponse: (Response response) {
      return response; // continue
    },
    onError: (DioError e) {
      return e; //continue
    },
  );

  static init() {
    if (!dio.interceptors.contains(_interceptorsWrapper)) {
      dio.interceptors.add(_interceptorsWrapper);
    }
  }

  ///广告相关数据
  static queryAdList() {
    return dio.get("api/ad/", queryParameters: {});
  }
}
