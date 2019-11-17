import 'dart:async';
import 'package:dio/dio.dart';

class API {
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
