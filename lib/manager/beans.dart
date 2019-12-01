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
  String code;
  Data data;

  AdListInfo({this.code, this.data});

  AdListInfo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int cardIndex;
  String id;
  String listGoto;
  String listUrl;
  String showCardGoto;
  String showCardUrl;
  String splashGoto;
  String splashUrl;

  Data(
      {this.cardIndex,
      this.id,
      this.listGoto,
      this.listUrl,
      this.showCardGoto,
      this.showCardUrl,
      this.splashGoto,
      this.splashUrl});

  Data.fromJson(Map<String, dynamic> json) {
    cardIndex = json['card_index'];
    id = json['id'];
    listGoto = json['list_goto'];
    listUrl = json['list_url'];
    showCardGoto = json['showCard_goto'];
    showCardUrl = json['showCard_url'];
    splashGoto = json['splash_goto'];
    splashUrl = json['splash_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['card_index'] = this.cardIndex;
    data['id'] = this.id;
    data['list_goto'] = this.listGoto;
    data['list_url'] = this.listUrl;
    data['showCard_goto'] = this.showCardGoto;
    data['showCard_url'] = this.showCardUrl;
    data['splash_goto'] = this.splashGoto;
    data['splash_url'] = this.splashUrl;
    return data;
  }
}

class phoneNumberInfo {
  List<Numberlist> numberlist;

  phoneNumberInfo({this.numberlist});

  phoneNumberInfo.fromJson(Map<String, dynamic> json) {
    if (json['numberlist'] != null) {
      numberlist = new List<Numberlist>();
      json['numberlist'].forEach((v) {
        numberlist.add(new Numberlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.numberlist != null) {
      data['numberlist'] = this.numberlist.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Numberlist {
  String phone;
  String des;

  Numberlist({this.phone, this.des});

  Numberlist.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    des = json['des'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['des'] = this.des;
    return data;
  }
}
