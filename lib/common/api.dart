import 'dart:async';
import 'package:dio/dio.dart';

var basicAuth =
    'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1NzgyMzI3ODYsInVzZXJfbmFtZSI6ImFkbWluIiwiYXV0aG9yaXRpZXMiOlsiU1lTVEVNIiwiVVNFUiIsIkFETUlOIl0sImp0aSI6IjJhZDQyYmFmLTQyOGYtNDQ4Zi04NzBlLWY4YzY4MjY5ZTE5MCIsImNsaWVudF9pZCI6ImFwcGNsaWVudCIsInNjb3BlIjpbIm9wZW5pZCJdfQ.gvfaWW7dq6p3ovMSb1C3n_bA_3OQtQdRpb41MR6CrlKqzuMdpZKqxA4rFgPEtVzCof2wMKy2MAW-lY6mDqH_kyyRosGV2DLjSWG3uXhd4KpryKj9Cc8dZWTPcxaISp6q0EH-XjWtAMsI94419gtjhvRAfQKO_IDVH9HeTQkAcClJ9j_qwNpMWpJ0XTkwHb3rb_gVl_DE8icfU5s-Vl5gVL3SnUeMwTpRl6pGg9mVg_gYd43rHPaQJD3YFzJc7JnGKhngOUJlmo6lKHyMVS2-3n1yiA_YLgKttfS5JbgOgLydfAALK8Qv2qRQhHn4vVb4iI2AsC3hk3ZTxFD083usMQ';

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

class Api {
  static Dio dio = Dio(BaseOptions(
    baseUrl: "http://39.96.16.125:8001/",
    connectTimeout: 5000,
    receiveTimeout: 3000,
    responseType: ResponseType.plain,
    headers: {"Authorization": basicAuth},
  ));

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

  ///开屏相关
  static querySplashList() {
    return dio.get("api/advertisement/get/ad", queryParameters: {});
  }

  ///热线电话相关
  static queryPhoneNumList() {
    return dio.get("api/phoneNumbers.json", queryParameters: {});
  }

  ///升级相关
  static queryUpgradeList() {
    return dio.get("api/upgrade.json", queryParameters: {});
  }
}

class ApiForNearby {
  static Dio dio = Dio(BaseOptions(
      baseUrl: "http://123.206.176.51:5000/",
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

  ///list数据相关
  static queryIgnList(String num) {
    return dio.get("/data/ign/?page=" + num, queryParameters: {});
  }
}
