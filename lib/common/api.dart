import 'package:dio/dio.dart';
import 'package:hatchery/common/utils.dart';
import 'package:hatchery/configs.dart';

class ApiForServicePage {
  static Dio dio = Dio(BaseOptions(
    baseUrl: API_HOST,
    connectTimeout: 5000,
    receiveTimeout: 3000,
    responseType: ResponseType.plain,
    headers: {"Authorization": BASIC_AUTH},
  ));

  static InterceptorsWrapper _interceptorsWrapper =
      InterceptorsWrapper(onRequest: (options, handler) {
    // Do something before request is sent
    return handler.next(options); //continue
    // If you want to resolve the request with some custom data，
    // you can resolve a `Response` object eg: return `dio.resolve(response)`.
    // If you want to reject the request with a error message,
    // you can reject a `DioError` object eg: return `dio.reject(dioError)`
  }, onResponse: (response, handler) {
    // Do something with response data
    return handler.next(response); // continue
    // If you want to reject the request with a error message,
    // you can reject a `DioError` object eg: return `dio.reject(dioError)`
  }, onError: (DioError e, handler) {
    // Do something with response error
    return handler.next(e); //continue
    // If you want to resolve the request with some custom data，
    // you can resolve a `Response` object eg: return `dio.resolve(response)`.
  });

  static init() {
    if (!dio.interceptors.contains(_interceptorsWrapper)) {
      dio.interceptors.add(_interceptorsWrapper);
    }
  }

  ///服务顶部数据
  static queryServiceTop(parameters) {
    return dio.get("/api/services/get/services", queryParameters: parameters);
  }

  ///服务list数据
  static queryServiceList(parameters) {
    return dio.get("api/feed/get/feeds", queryParameters: parameters);
  }
}

class Api {
  static Dio dio = Dio(BaseOptions(
    baseUrl: API_HOST,
    connectTimeout: 5000,
    receiveTimeout: 3000,
    responseType: ResponseType.plain,
    headers: {"Authorization": BASIC_AUTH},
  ));

  static InterceptorsWrapper _interceptorsWrapper =
      InterceptorsWrapper(onRequest: (options, handler) {
    // Do something before request is sent
    return handler.next(options); //continue
    // If you want to resolve the request with some custom data，
    // you can resolve a `Response` object eg: return `dio.resolve(response)`.
    // If you want to reject the request with a error message,
    // you can reject a `DioError` object eg: return `dio.reject(dioError)`
  }, onResponse: (response, handler) {
    // Do something with response data
    return handler.next(response); // continue
    // If you want to reject the request with a error message,
    // you can reject a `DioError` object eg: return `dio.reject(dioError)`
  }, onError: (DioError e, handler) {
    // Do something with response error
    return handler.next(e); //continue
    // If you want to resolve the request with some custom data，
    // you can resolve a `Response` object eg: return `dio.resolve(response)`.
  });

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

class ApiForNearbyPage {
  static Dio dio = Dio(BaseOptions(
    baseUrl: API_HOST,
    connectTimeout: 5000,
    receiveTimeout: 3000,
    responseType: ResponseType.plain,
    headers: {"Authorization": BASIC_AUTH},
  ));

  static InterceptorsWrapper _interceptorsWrapper =
      InterceptorsWrapper(onRequest: (options, handler) {
    // Do something before request is sent
    return handler.next(options); //continue
    // If you want to resolve the request with some custom data，
    // you can resolve a `Response` object eg: return `dio.resolve(response)`.
    // If you want to reject the request with a error message,
    // you can reject a `DioError` object eg: return `dio.reject(dioError)`
  }, onResponse: (response, handler) {
    // Do something with response data
    return handler.next(response); // continue
    // If you want to reject the request with a error message,
    // you can reject a `DioError` object eg: return `dio.reject(dioError)`
  }, onError: (DioError e, handler) {
    // Do something with response error
    return handler.next(e); //continue
    // If you want to resolve the request with some custom data，
    // you can resolve a `Response` object eg: return `dio.resolve(response)`.
  });

  static init() {
    if (!dio.interceptors.contains(_interceptorsWrapper)) {
      dio.interceptors.add(_interceptorsWrapper);
    }
  }

  ///服务list数据
  static queryNearbyList(parameters) {
    return dio.get("api/feed/get/feeds", queryParameters: parameters);
  }
}

class ApiForBanner {
  static Dio dio = Dio(BaseOptions(
    baseUrl: API_HOST,
    connectTimeout: 5000,
    receiveTimeout: 3000,
    responseType: ResponseType.plain,
    headers: {"Authorization": BASIC_AUTH},
  ));

  static InterceptorsWrapper _interceptorsWrapper =
      InterceptorsWrapper(onRequest: (options, handler) {
    return handler.next(options); //continue
  }, onResponse: (response, handler) {
    print(
        'HTTP: statusCode = ${response.statusCode} ;data = ${response.data} ');
    return handler.next(response); // continue
  }, onError: (DioError e, handler) {
    return handler.next(e); //continue
  });

  static init() {
    if (!dio.interceptors.contains(_interceptorsWrapper)) {
      dio.interceptors.add(_interceptorsWrapper);
    }
  }

  ///服务list数据
  static queryBannerList(parameters) {
    return dio.get("api/banner/banner_list", queryParameters: parameters);
  }
}

class ApiForReportSt {
  static Dio dio = Dio(BaseOptions(
    baseUrl: API_HOST,
    connectTimeout: 5000,
    receiveTimeout: 3000,
    responseType: ResponseType.plain,
    headers: {"Authorization": BASIC_AUTH, "Content-Type": CONTENT_TYPE},
  ));

  static InterceptorsWrapper _interceptorsWrapper =
      InterceptorsWrapper(onRequest: (options, handler) {
    // Do something before request is sent
    return handler.next(options); //continue
    // If you want to resolve the request with some custom data，
    // you can resolve a `Response` object eg: return `dio.resolve(response)`.
    // If you want to reject the request with a error message,
    // you can reject a `DioError` object eg: return `dio.reject(dioError)`
  }, onResponse: (response, handler) {
    // Do something with response data
    return handler.next(response); // continue
    // If you want to reject the request with a error message,
    // you can reject a `DioError` object eg: return `dio.reject(dioError)`
  }, onError: (DioError e, handler) {
    // Do something with response error
    return handler.next(e); //continue
    // If you want to resolve the request with some custom data，
    // you can resolve a `Response` object eg: return `dio.resolve(response)`.
  });

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

class API {
  static Dio _dio = Dio(BaseOptions(
    baseUrl: API_HOST,
    connectTimeout: API_CONNECT_TIMEOUT,
    receiveTimeout: API_RECEIVE_TIMEOUT,
    headers: {"Authorization": BASIC_AUTH},
    // responseType: ResponseType.plain,
  ));

  static InterceptorsWrapper _interceptorsWrapper =
      InterceptorsWrapper(onRequest: (options, handler) {
    print('HTTP.onRequest: options = $options ');
    return handler.next(options); //continue
  }, onResponse: (response, handler) {
    print(
        'HTTP.onResponse: statusCode = ${response.statusCode} ;data = ${response.data} ');
    return handler.next(response); // continue
  }, onError: (DioError e, handler) {
    print('HTTP.onError: = ${e} ');
    return handler.next(e); //continue
  });

  static init() {
    isNetworkConnect().then((value) {
      if (!value) {
        showToast('网络未连接，请检查网络设置');
      }
    });
    if (!_dio.interceptors.contains(_interceptorsWrapper)) {
      _dio.interceptors.add(_interceptorsWrapper);
    }
  }

  ///软文列表
  ///page_num: 页码从0开始
  /// page_size: 每页数量
  /// service_id: 服务或者Tab_id
  // static getArticleList(Map<String, String> parameters) {
  static getArticleList(int page, int size, String pageId) async {
    Map<String, Object> query = {
      "page_num": page,
      "page_size": size,
      "service_id": pageId,
      "client_id": '36ff662f-3041-5c10-8bde-65e6fb86523b',
    };
    init();
    try {
      Response response = await _dio.get("/post/public/list", queryParameters: query);
      return ApiResult.of(response.data);
    } catch (e) {
      print("e = $e");
    }
  }
}

class ApiResult {
  int code = 0;
  String message = "";
  Map<String,dynamic> parsed;

  ApiResult(this.parsed) {
    code = parsed['code'];
    message = parsed['message'];
  }

  factory ApiResult.of(Map<String,dynamic> response) {
    return ApiResult(response);
  }

  bool isSuccess() {
    return code == 100000;
  }

  dynamic getData() {
    return parsed['data'];
  }
}
