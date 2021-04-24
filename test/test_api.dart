import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatchery/api/API.dart';

void main() {
  test('联系人', () async {
    API.skipCheck = true;
    var response = await API.getContacts(0, 10);
    expect(response.isSuccess(), true);
  });

  test('软文列表', () async {
    API.skipCheck = true;
    var response = await API.getArticleList(0, 10, "tab1");
    expect(response.isSuccess(), true);
  });

  test('获取配置', () async {
    API.skipCheck = true;
    var response = await API.getConfig();
    expect(response.isSuccess(), true);
  });

  test('获取 banner ', () async {
    API.skipCheck = true;
    var response = await API.getBannerList(0, 10, "tab1");
    expect(response.isSuccess(), true);
  });

  test('获取通知列表', () async {
    API.skipCheck = true;
    var response = await API.getNoticeList(0, 10, "tab1");
    expect(response.isSuccess(), true);
  });
  test('获取开屏广告', () async {
    API.skipCheck = true;
    var response = await API.getSplashADList(0, 10, "tab1");
    expect(response.isSuccess(), true);
  });
  test('获取弹框广告', () async {
    API.skipCheck = true;
    var response = await API.getPopupADList(0, 10, "tab1");
    expect(response.isSuccess(), true);
  });

  test('查询报修', () async {
    API.skipCheck = true;
    var response = await API.getReports(0, 10, "uid_test");
    expect(response.isSuccess(), true);
  });
  test('提交报修', () async {
    API.skipCheck = true;
    var response = await API.postReport("title","content", "18611223344", "uid_test",
        ["https://avatars.githubusercontent.com/u/3735867?v=4"]);
    expect(response.isSuccess(), true);
  });
  test('查询意见反馈', () async {
    API.skipCheck = true;
    var response = await API.getFeedback(0, 10, "uid_test");
    expect(response.isSuccess(), true);
  });

  test('提交意见反馈', () async {
    API.skipCheck = true;
    var response = await API.postFeedback(
        "title123",
        "content222",
        "18611223344",
        "uid_test",
        ["https://avatars.githubusercontent.com/u/3735867?v=4"]);
    expect(response.isSuccess(), true);
  });

  test('上传', () async {
    FormData formData = new FormData.fromMap({
    'file': await MultipartFile.fromString("aaaaaa",filename:'a.jpg')
    });
    Response response = await Dio().post(
        "http://106.12.147.150:8080/files/upload", data: formData);
    print("response= ${response.data}");
  });

  ///
}
