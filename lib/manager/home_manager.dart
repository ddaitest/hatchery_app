import 'dart:collection';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:hatchery/beans/beans.dart';
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
  List<Post> _posts = List<Post>();

  PageStatus get status => _status;

  UnmodifiableListView<BannerInfo> get banner => UnmodifiableListView(_banner);

  UnmodifiableListView<Post> get posts => UnmodifiableListView(_posts);

  HomeManager(BuildContext context) {
    _loadBanner();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _loadBanner(){
    List<BannerInfo> info = List<BannerInfo>();
    info.add(BannerInfo(
        id: "id",
        image: "https://v1.vuepress.vuejs.org/hero.png",
        action: "http://baidu.com"));
    info.add(BannerInfo(
        id: "id",
        image: "https://v1.vuepress.vuejs.org/hero.png",
        action: "http://baidu.com"));
    info.add(BannerInfo(
        id: "id",
        image: "https://v1.vuepress.vuejs.org/hero.png",
        action: "http://baidu.com"));
    _banner.addAll(info);
  }

  void _loadData() async {
    Response response = await API.home.getBanners("5dfe047470492f05963a1eca");
    var result = response.getResult();
    if (result != null) {
      for (var x in result) {
        _posts.add(Post.fromJson(x));
      }
      notifyListeners();
    }
  }
}
