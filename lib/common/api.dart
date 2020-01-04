import 'package:dio/dio.dart';
import 'package:hatchery/configs.dart';

class ApiForServicePage {
  static Dio dio = Dio(BaseOptions(
    baseUrl: "http://39.96.16.125:8001/",
    connectTimeout: 5000,
    receiveTimeout: 3000,
    responseType: ResponseType.plain,
    headers: {"Authorization": BASIC_AUTH},
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

  ///服务list数据
  static queryServiceList(parameters) {
    return dio.get("api/feed/get/feeds", queryParameters: parameters);
  }
}

class Api {
  static Dio dio = Dio(BaseOptions(
    baseUrl: "http://39.96.16.125:8001/",
    connectTimeout: 5000,
    receiveTimeout: 3000,
    responseType: ResponseType.plain,
    headers: {"Authorization": BASIC_AUTH},
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
    return dio.get("api/versions/check_update", queryParameters: {});
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

class ApiForReportSt {
  static Dio dio = Dio(BaseOptions(
    baseUrl: "http://39.96.16.125:8001/",
    connectTimeout: 5000,
    receiveTimeout: 3000,
    responseType: ResponseType.plain,
    headers: {"Authorization": BASIC_AUTH, "Content-Type": CONTENT_TYPE},
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

  ///报事报修post
  static postReportData(postData) {
    return dio.post("api/feedback/create/help", data: postData);
  }

  ///报事报修图片上传
  static uploadReportImage(formdata) {
    return dio.post("files/upload", data: formdata);
  }
}
