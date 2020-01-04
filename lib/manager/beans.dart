class BannerInfo {
  BannerInfo({this.id, this.image, this.action});

  String id = "";
  String image = "";
  String action = "";

  factory BannerInfo.fromJson(Map<String, dynamic> json) {
    return BannerInfo(
      id: json['id'].toString(),
      image: json['image'],
      action: json['action'],
    );
  }
}

class AdInfo {
  AdInfo({this.id, this.image, this.action, this.type});

  num id;

  String image = "";
  String action = "";
  num type;

  factory AdInfo.fromJson(Map<String, dynamic> json) {
    return AdInfo(
      id: json['id'],
      image: json['image'],
      action: json['action'],
      type: json['type'],
    );
  }
}

class Article {
  Article(
      {this.id,
      this.title,
      this.thumbnail,
      this.summary,
      this.publishOn,
      this.webUrl});

  String id;
  String webUrl;
  String title;
  String thumbnail;
  String summary = "...";
  num publishOn;
}

class ServiceListInfo {
  String id;
  String title;
  String image;
  String thumbnail;
  String url;
  String contents;
  int status;
  String clientId;
  int updateTime;
  int createTime;
  bool isWeb;
  String categoryId;
  String serviceId;

  ServiceListInfo(
      {this.id,
      this.title,
      this.image,
      this.thumbnail,
      this.url,
      this.contents,
      this.status,
      this.clientId,
      this.updateTime,
      this.createTime,
      this.isWeb,
      this.categoryId,
      this.serviceId});

  ServiceListInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    thumbnail = json['thumbnail'];
    url = json['url'];
    contents = json['contents'];
    status = json['status'];
    clientId = json['client_id'];
    updateTime = json['update_time'];
    createTime = json['create_time'];
    isWeb = json['is_web'];
    categoryId = json['category_id'];
    serviceId = json['service_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['thumbnail'] = this.thumbnail;
    data['url'] = this.url;
    data['contents'] = this.contents;
    data['status'] = this.status;
    data['client_id'] = this.clientId;
    data['update_time'] = this.updateTime;
    data['create_time'] = this.createTime;
    data['is_web'] = this.isWeb;
    data['category_id'] = this.categoryId;
    data['service_id'] = this.serviceId;
    return data;
  }
}

class AdListInfo {
  String id;
  String description;
  int status;
  String clientId;
  int updateTime;
  int createTime;
  String imgUrl;
  String webUrl;

  AdListInfo(
      {this.id,
      this.description,
      this.status,
      this.clientId,
      this.updateTime,
      this.createTime,
      this.imgUrl,
      this.webUrl});

  AdListInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    status = json['status'];
    clientId = json['client_id'];
    updateTime = json['update_time'];
    createTime = json['create_time'];
    imgUrl = json['img_url'];
    webUrl = json['web_url'];
  }
}

class phoneNumberInfo {
  String name;
  String phone;
  String des;

  phoneNumberInfo({this.name, this.phone, this.des});

  phoneNumberInfo.fromJson(Map<String, dynamic> json) {
    name = json['id'];
    phone = json['phone'];
    des = json['des'];
  }
}

class updataInfo {
  String id;
  String verson;
  String url;
  String introduction;
  String clientId;
  int updateTime;
  int createTime;

  updataInfo(
      {this.id,
      this.verson,
      this.url,
      this.introduction,
      this.clientId,
      this.updateTime,
      this.createTime});

  updataInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    verson = json['verson'];
    url = json['url'];
    introduction = json['introduction'];
    clientId = json['client_id'];
    updateTime = json['update_time'];
    createTime = json['create_time'];
  }
}

class IgnDataInfo {
  String gotoUrl;
  String img;
  String score;
  String title;

  IgnDataInfo({this.gotoUrl, this.img, this.score, this.title});

  IgnDataInfo.fromJson(Map<String, dynamic> json) {
    gotoUrl = json['goto_url'];
    img = json['img'];
    score = json['score'];
    title = json['title'];
  }
}

class ReportSt {
  int code;
  String info;

  ReportSt({this.code, this.info});

  ReportSt.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    info = json['info'];
  }
}
