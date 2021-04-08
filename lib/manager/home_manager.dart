import 'dart:collection';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:hatchery/api/entity.dart';
import 'package:hatchery/common/PageStatus.dart';
import 'package:hatchery/common/api.dart';
import 'package:flutter/material.dart';
import 'package:hatchery/common/apiCommon.dart';
import 'package:hatchery/configs.dart';
import 'package:hatchery/common/utils.dart';
import 'package:hatchery/common/exts.dart';

class HomeManager extends ChangeNotifier {
  //当前页面状态
  PageStatus _status = PageStatus.LOADING;

  String _articlesResult = '';
  Map _articlesParsed = {};

  //banner 数据
  List<BannerInfo> _banner = [];

  //公告内容
  List<Notice> _notices = [];

  //软文
  List<Article> _articlesList = [];
  int _articlesDataLength = 0;

  int get articlesDataTotal => _articlesDataLength;

  PageStatus get status => _status;

  UnmodifiableListView<BannerInfo> get banner => UnmodifiableListView(_banner);

  UnmodifiableListView<Notice> get posts => UnmodifiableListView(_notices);

  UnmodifiableListView<Article> get articlesList =>
      UnmodifiableListView(_articlesList);

  Map<String, dynamic> _articlesParameters = {
    'page_num': 0,
    'page_size': 10,
    'service_id': '',
    'client_id': ''
  };

  HomeManager(BuildContext context) {
    _loadBanner();
    _loadPost();
    _loadArticles();
    // _loadArticlesRequest(0, 10, '1111');
  }

  @override
  void dispose() {
    super.dispose();
  }

  _loadBanner() {
    List<BannerInfo> info = <BannerInfo>[];
    _banner.addAll(info);
  }

  Future _loadArticlesRequest(int page, int size, String serviceId) async {
    apiResponseCheck(API.getArticleList(page, size, serviceId)).then(
      (value) {
        print("DEBUG=> _articlesParsed $value");
        if (value != null) {
          for (var x in value) {
            addArticles(Article.fromJson(x));
          }
          notifyListeners();
        }
      },
    );
    // ApiResult result = await API.getArticleList(page, pageSize, "tab1");
    // if (result.isSuccess()) {
    //   for (var x in result.getData()) {
    //     addArticles(ArticleDataInfo.fromJson(x));
    //   }
    //   notifyListeners();
    // }
  }

  _loadArticles() async {
    final thumbnail =
        "https://upload-images.jianshu.io/upload_images/10392521-682342d2186572c0.jpg-mobile?imageMogr2/auto-orient/strip|imageView2/2/w/750/format/webp";
    final summary1 =
        "前段时间一直在进行hybrid app的调优工作，主要工作集中在webview的优化。工程实践虽然离不开方法论的指导，但到了具体实施仍然千差万别。webview优化存在典型的加载时间与优化难度负相关的关系。这次调优，我们也分别从纯前端层面以及Xcode/Java层面进行双向优化的工作。相较而言，纯前端优化有更多传统、经典的方法论作为指导，效果更容易获取。而Xcode/Java层，就需要更多的借鉴和自我创新。今天这篇文章，记录下前端，既纯h5层面可以优化的部分思路。";
//    List<Article> data = model.getListData(pageType);
//    final enablePullUp = model.getHasMore(pageType);
    final enablePullUp = false;
    List<Article> data = [];
    data.add(Article(
        "id",
        thumbnail,
        "title",
        summary1,
        "contentType",
        "source",
        "status",
        "clientId",
        "redirectUrl",
        "updateTime",
        "createTime"));
    data.add(Article(
        "id",
        thumbnail,
        "title",
        summary1,
        "contentType",
        "source",
        "status",
        "clientId",
        "redirectUrl",
        "updateTime",
        "createTime"));
    data.add(Article(
        "id",
        thumbnail,
        "title",
        summary1,
        "contentType",
        "source",
        "status",
        "clientId",
        "redirectUrl",
        "updateTime",
        "createTime"));
    data.add(Article(
        "id",
        thumbnail,
        "title",
        summary1,
        "contentType",
        "source",
        "status",
        "clientId",
        "redirectUrl",
        "updateTime",
        "createTime"));
    data.add(Article(
        "id",
        thumbnail,
        "title",
        summary1,
        "contentType",
        "source",
        "status",
        "clientId",
        "redirectUrl",
        "updateTime",
        "createTime"));
    _articlesList.addAll(data);
    notifyListeners();
  }

  var page = 0;
  int pageSize = 10;

  // loadArticles() async {
  //   ApiResult result = await API.getArticleList(page, pageSize, "tab1");
  //   if (result.isSuccess()) {
  //     print("ApiResult.data = ${result.getData()}");
  //   }
  // }

  void _loadPost() async {
    final thumbnail =
        "https://upload-images.jianshu.io/upload_images/10392521-682342d2186572c0.jpg-mobile?imageMogr2/auto-orient/strip|imageView2/2/w/750/format/webp";
    final summary =
        "前段时间一直在进行hybrid app的调优工作，主要工作集中在webview的优化。工程实践虽然离不开方法论的指导，但到了具体实施仍然千差万别。webview优化存在典型的加载时间与优化难度负相关的关系。这次调优，我们也分别从纯前端层面以及Xcode/Java层面进行双向优化的工作。相较而言，纯前端优化有更多传统、经典的方法论作为指导，效果更容易获取。而Xcode/Java层，就需要更多的借鉴和自我创新。今天这篇文章，记录下前端，既纯h5层面可以优化的部分思路。";
    List<Notice> data = [];
    data.add(Notice("id", thumbnail, "title", summary, "contentType", "source",
        "status", "clientId", "redirectUrl", "updateTime", "createTime"));
    data.add(Notice("id", thumbnail, "title", summary, "contentType", "source",
        "status", "clientId", "redirectUrl", "updateTime", "createTime"));
    data.add(Notice("id", thumbnail, "title", summary, "contentType", "source",
        "status", "clientId", "redirectUrl", "updateTime", "createTime"));
    data.add(Notice("id", thumbnail, "title", summary, "contentType", "source",
        "status", "clientId", "redirectUrl", "updateTime", "createTime"));
    data.add(Notice("id", thumbnail, "title", summary, "contentType", "source",
        "status", "clientId", "redirectUrl", "updateTime", "createTime"));
    _notices.addAll(data);
    notifyListeners();
  }

  void addArticles(Article item) {
    _articlesList.add(item);
  }

  void clickBanner(int index) {}
}
