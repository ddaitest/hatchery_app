import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hatchery/common/utils.dart';
import 'package:hatchery/flavors/Flavors.dart';
import 'ApiResult.dart';

extension ExtendedDio on Dio {
  initWrapper() {
    InterceptorsWrapper wrapper =
        InterceptorsWrapper(onRequest: (options, handler) {
      print('HTTP.onRequest: ${options.uri} ');
      print('HTTP.onRequest: ${options.data} ');
      return handler.next(options); //continue
    }, onResponse: (response, handler) {
      print(
          'HTTP.onResponse: statusCode = ${response.statusCode} ;data = ${response.data} ');
      return handler.next(response); // continue
    }, onError: (DioError e, handler) {
      print('HTTP.onError: = ${e.message} ');
      print('HTTP.onError: = ${e.response?.data} ');
      print('HTTP.onError: = ${e.response?.statusCode} ');
      print('HTTP.onError: = ${e.response?.statusMessage} ');
      return handler.next(e); //continue
    });
    this.interceptors.add(wrapper);
    return this;
  }
}

class API {
  static Dio _dio = Dio(BaseOptions(
    baseUrl: Flavors.apiInfo.API_HOST,
    connectTimeout: Flavors.apiInfo.API_CONNECT_TIMEOUT,
    receiveTimeout: Flavors.apiInfo.API_RECEIVE_TIMEOUT,
    headers: {"Authorization": Flavors.apiInfo.BASIC_AUTH},
  )).initWrapper();

  static bool skipCheck = false;

  static init() {
    if (!skipCheck) {
      isNetworkConnect().then((value) {
        if (!value) {
          showToast('网络未连接，请检查网络设置');
        }
      });
    }
  }

  ///软文列表
  static Future<ApiResult> getArticleList(
      int page, int size, String pageId) async {
    Map<String, Object> query = {
      "page_num": page,
      "page_size": size,
      "service_id": pageId,
      "client_id": Flavors.appId.client_id,
    };
    init();
    try {
      Response response =
          await _dio.get("/post/public/list", queryParameters: query);
      return ApiResult.of(response.data);
    } catch (e) {
      print("e = $e");
      return ApiResult.error(e);
    }
  }

  ///获取配置
  static Future<ApiResult> getConfig() async {
    init();
    try {
      Response response =
          await _dio.get("api/config/${Flavors.appId.client_id}");
      return ApiResult.of(response.data);
    } catch (e) {
      print("e = $e");
      return ApiResult.error(e);
    }
  }

  ///获取Banner列表
  static Future<ApiResult> getBannerList(
      int page, int size, String pageId) async {
    Map<String, Object> query = {
      "page_num": page,
      "page_size": size,
      "service_id": pageId,
      "client_id": Flavors.appId.client_id,
    };
    init();
    try {
      Response response =
          await _dio.get("/banner/public/list", queryParameters: query);
      return ApiResult.of(response.data);
    } catch (e) {
      print("e = $e");
      return ApiResult.error(e);
    }
  }

  ///获取通知列表
  static Future<ApiResult> getNoticeList(
      int page, int size, String pageId) async {
    Map<String, Object> query = {
      "page_num": page,
      "page_size": size,
      "service_id": pageId,
      "client_id": Flavors.appId.client_id,
    };
    init();
    try {
      Response response =
          await _dio.get("/notice/public/list", queryParameters: query);
      return ApiResult.of(response.data);
    } catch (e) {
      print("e = $e");
      return ApiResult.error(e);
    }
  }

  ///获取开屏广告
  static Future<ApiResult> getSplashADList(
      int page, int size, String pageId) async {
    Map<String, Object> query = {
      "page_num": page,
      "page_size": size,
      "service_id": pageId,
      "client_id": Flavors.appId.client_id,
    };
    init();
    try {
      Response response =
          await _dio.get("/openadvs/public/list", queryParameters: query);
      return ApiResult.of(response.data);
    } catch (e) {
      print("e = $e");
      return ApiResult.error(e);
    }
  }

  ///弹框广告
  static Future<ApiResult> getPopupADList(
      int page, int size, String pageId) async {
    Map<String, Object> query = {
      "page_num": page,
      "page_size": size,
      "service_id": pageId,
      "client_id": Flavors.appId.client_id,
      "today_is_show": true,
    };
    init();
    try {
      Response response =
          await _dio.get("/popupadvs/public/list", queryParameters: query);
      return ApiResult.of(response.data);
    } catch (e) {
      print("e = $e");
      return ApiResult.error(e);
    }
  }

  ///上传图片
  static Future<ApiResult> uploadImage(
      String filePath, ProgressCallback callback) async {
    init();
    FormData formData = FormData.fromMap(
        {"file": await MultipartFile.fromFile(filePath, filename: 'file.jpg')});
    try {
      Response response = await _dio.post("files/upload",
          data: formData, onSendProgress: callback);
      return ApiResult.of(response.data);
    } catch (e) {
      print("e = $e");
      return ApiResult.error(e);
    }
  }

  ///联系人
  static Future<ApiResult> getContacts(int page, int size) async {
    Map<String, Object> query = {
      "page_num": page,
      "page_size": size,
      "client_id": Flavors.appId.client_id,
    };
    init();
    try {
      Response response =
          await _dio.get("/contacts/public/list", queryParameters: query);
      return ApiResult.of(response.data);
    } catch (e) {
      print("e = $e");
      return ApiResult.error(e);
    }
  }

  ///查询报修
  static Future<ApiResult> getReports(int page, int size, String uid) async {
    Map<String, Object> query = {
      "page_num": page,
      "page_size": size,
      "custom_id": uid,
      "client_id": Flavors.appId.client_id,
    };
    init();
    try {
      Response response =
          await _dio.get("/repairs/public/list", queryParameters: query);
      return ApiResult.of(response.data);
    } catch (e) {
      print("e = $e");
      return ApiResult.error(e);
    }
  }

  ///提交报修
  static Future<ApiResult> postReport(
      String content, String phone, String uid, List<String> photos) async {
    init();
    Map<String, Object> query = {
      "title": "title ${DateTime.now()}",
      "contents": content,
      "user_phone": phone,
      "custom_id": uid,
      "client_id": Flavors.appId.client_id,
    };
    query.addAll(photos.asMap().map((k, v) => MapEntry("img${k + 1}", v)));
    try {
      Response response = await _dio.post("/repairs/public/add",
          data: query,
          options: Options(contentType: ContentType.json.toString()));
      return ApiResult.of(response.data);
    } catch (e) {
      print("e = $e");
      return ApiResult.error(e);
    }
  }

  ///查询意见反馈
  static Future<ApiResult> getFeedback(int page, int size, String uid) async {
    Map<String, Object> query = {
      "page_num": page,
      "page_size": size,
      "custom_id": uid,
      "client_id": Flavors.appId.client_id,
    };
    init();
    try {
      Response response =
          await _dio.get("/feedback/public/list", queryParameters: query);
      return ApiResult.of(response.data);
    } catch (e) {
      print("e = $e");
      return ApiResult.error(e);
    }
  }

  ///提交意见反馈
  static Future<ApiResult> postFeedback(
      String content, String phone, String uid, List<String> photos) async {
    init();
    Map<String, Object> query = {
      "title": "title ${DateTime.now()}",
      "contents": content,
      "user_phone": phone,
      "custom_id": uid,
      "client_id": Flavors.appId.client_id,
    };
    query.addAll(photos.asMap().map((k, v) => MapEntry("img${k + 1}", v)));
    try {
      Response response = await _dio.post("/feedback/public/add",
          data: query,
          options: Options(contentType: ContentType.json.toString()));
      return ApiResult.of(response.data);
    } catch (e) {
      print("e = $e");
      return ApiResult.error(e);
    }
  }
}
