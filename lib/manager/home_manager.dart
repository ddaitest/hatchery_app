import 'dart:collection';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:hatchery/common/PageStatus.dart';
import 'package:hatchery/common/api.dart';
import 'package:hatchery/manager/beans.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/common/exts.dart';

class HomeManager extends ChangeNotifier {
  //当前页面状态
  PageStatus _status = PageStatus.LOADING;

  //banner 数据
  List<BannerInfo> _banner = List<BannerInfo>();

  //公告内容
  List<Notice> _notices = List<Notice>();

  //软文
  List<Article> _articles = List<Article>();

  PageStatus get status => _status;

  UnmodifiableListView<BannerInfo> get banner => UnmodifiableListView(_banner);

  UnmodifiableListView<Notice> get posts => UnmodifiableListView(_notices);

  UnmodifiableListView<Article> get articles => UnmodifiableListView(_articles);

  HomeManager(BuildContext context) {
    _loadBanner();
    _loadPost();
    _loadArticles();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _loadBanner() {
    List<BannerInfo> info = List<BannerInfo>();
    info.add(BannerInfo(
        id: "id",
        imgUrl: "images/demo/banner_demo2.png",
        webUrl: "http://baidu.com"));
    info.add(BannerInfo(
        id: "id",
        imgUrl: "images/demo/banner_demo3.jpg",
        webUrl: "http://baidu.com"));
    info.add(BannerInfo(
        id: "id",
        imgUrl: "images/demo/banner_demo4.png",
        webUrl: "http://baidu.com"));
    info.add(BannerInfo(
        id: "id",
        imgUrl: "images/demo/banner_demo5.jpg",
        webUrl: "http://baidu.com"));
    info.add(BannerInfo(
        id: "id",
        imgUrl: "images/demo/banner_demo6.jpeg",
        webUrl: "http://baidu.com"));
    _banner.addAll(info);
  }

  _loadArticles() async {
    final thumbnail =
        "https://upload-images.jianshu.io/upload_images/10392521-682342d2186572c0.jpg-mobile?imageMogr2/auto-orient/strip|imageView2/2/w/750/format/webp";
    final summary =
        "前段时间一直在进行hybrid app的调优工作，主要工作集中在webview的优化。工程实践虽然离不开方法论的指导，但到了具体实施仍然千差万别。webview优化存在典型的加载时间与优化难度负相关的关系。这次调优，我们也分别从纯前端层面以及Xcode/Java层面进行双向优化的工作。相较而言，纯前端优化有更多传统、经典的方法论作为指导，效果更容易获取。而Xcode/Java层，就需要更多的借鉴和自我创新。今天这篇文章，记录下前端，既纯h5层面可以优化的部分思路。";
//    List<Article> data = model.getListData(pageType);
//    final enablePullUp = model.getHasMore(pageType);
    final enablePullUp = false;
    List<Article> data = List<Article>();
    data.add(Article(title: "AAA", thumbnail: thumbnail, contents: summary));
    data.add(Article(title: "bbb", thumbnail: thumbnail, contents: summary));
    data.add(Article(title: "ccc", thumbnail: thumbnail, contents: summary));
    data.add(Article(title: "ddd", thumbnail: thumbnail, contents: summary));
    data.add(Article(title: "eee", thumbnail: thumbnail, contents: summary));
    _articles.addAll(data);
    notifyListeners();
  }

//  void _loadPost2() async {
//    Response response = await API.home.getBanners("5dfe047470492f05963a1eca");
//    var result = response.getResult();
//    if (result != null) {
//      for (var x in result) {
//        _notices.add(Notice.fromJson(x));
//      }
//      notifyListeners();
//    }
//  }

  void _loadPost() async {
    final thumbnail =
        "https://upload-images.jianshu.io/upload_images/10392521-682342d2186572c0.jpg-mobile?imageMogr2/auto-orient/strip|imageView2/2/w/750/format/webp";
    final summary =
        "前段时间一直在进行hybrid app的调优工作，主要工作集中在webview的优化。工程实践虽然离不开方法论的指导，但到了具体实施仍然千差万别。webview优化存在典型的加载时间与优化难度负相关的关系。这次调优，我们也分别从纯前端层面以及Xcode/Java层面进行双向优化的工作。相较而言，纯前端优化有更多传统、经典的方法论作为指导，效果更容易获取。而Xcode/Java层，就需要更多的借鉴和自我创新。今天这篇文章，记录下前端，既纯h5层面可以优化的部分思路。";
    List<Notice> data = List<Notice>();
    data.add(Notice("", "公告：小区停水", "summary", "content", 1, "client_id", 1, 1));
    data.add(Notice("", "公告：小区停水", "summary", "content", 1, "client_id", 1, 1));
    data.add(Notice("", "公告：小区停水", "summary", "content", 1, "client_id", 1, 1));
    data.add(Notice("", "公告：小区停水", "summary", "content", 1, "client_id", 1, 1));
    _notices.addAll(data);
    notifyListeners();
  }

  void clickBanner(int index) {}
}
