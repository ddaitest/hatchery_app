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
  String allRate;
  String songId;
  String rankChange;
  String biaoshi;
  String author;
  String albumId;
  String picSmall;
  String title;
  String picBig;
  String albumTitle;

  ServiceListInfo(
      {this.allRate,
      this.songId,
      this.rankChange,
      this.biaoshi,
      this.author,
      this.albumId,
      this.picSmall,
      this.title,
      this.picBig,
      this.albumTitle});

  ServiceListInfo.fromJson(Map<String, dynamic> json) {
    allRate = json['all_rate'];
    songId = json['song_id'];
    rankChange = json['rank_change'];
    biaoshi = json['biaoshi'];
    author = json['author'];
    albumId = json['album_id'];
    picSmall = json['pic_small'];
    title = json['title'];
    picBig = json['pic_big'];
    albumTitle = json['album_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['all_rate'] = this.allRate;
    data['song_id'] = this.songId;
    data['rank_change'] = this.rankChange;
    data['biaoshi'] = this.biaoshi;
    data['author'] = this.author;
    data['album_id'] = this.albumId;
    data['pic_small'] = this.picSmall;
    data['title'] = this.title;
    data['pic_big'] = this.picBig;
    data['album_title'] = this.albumTitle;
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
  int code;
  bool mustUpdate;
  bool showUpdate;
  String updateMessage;
  String android_url;
  String ios_url;

  updataInfo(
      {this.code,
      this.mustUpdate,
      this.showUpdate,
      this.updateMessage,
      this.android_url,
      this.ios_url});

  updataInfo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    mustUpdate = json['must_update'];
    showUpdate = json['show_update'];
    updateMessage = json['update_message'];
    android_url = json['android_url'];
    ios_url = json['ios_url'];
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
