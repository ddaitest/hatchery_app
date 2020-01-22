import 'package:json_annotation/json_annotation.dart';

part 'beans.g.dart';

///flutter pub run build_runner build

/// 物业公告
@JsonSerializable()
class Notice {
  String id = "";
  String title = "";
  String summary = "";
  String content = "";
  num status = 1;
  @JsonKey(name: 'client_id')
  String clientId = "";
  @JsonKey(name: 'update_time')
  num updateTime = 0;

  @JsonKey(name: 'create_time')
  num createTime = 0;

  Notice(this.id, this.title, this.summary, this.content, this.status,
      this.clientId, this.updateTime, this.createTime);

  factory Notice.fromJson(Map<String, dynamic> json) => _$NoticeFromJson(json);

  Map<String, dynamic> toJson() => _$NoticeToJson(this);
}

/// Banner 信息
@JsonSerializable()
class BannerInfo {
  String id;
  String description;
  int status;

  @JsonKey(name: 'client_id')
  String clientId;
  @JsonKey(name: 'update_time')
  int updateTime;
  @JsonKey(name: 'create_time')
  int createTime;
  @JsonKey(name: 'img_url')
  String imgUrl;
  @JsonKey(name: 'web_url')
  String webUrl;
  @JsonKey(name: 'category_id')
  String categoryId;

  BannerInfo(
      {this.id,
      this.description,
      this.status,
      this.clientId,
      this.updateTime,
      this.createTime,
      this.imgUrl,
      this.webUrl,
      this.categoryId});

  factory BannerInfo.fromJson(Map<String, dynamic> json) =>
      _$BannerInfoFromJson(json);

  Map<String, dynamic> toJson() => _$BannerInfoToJson(this);
}

///广告信息
@JsonSerializable()
class AdListInfo {
  String id;
  String description;
  int status;
  @JsonKey(name: 'client_id')
  String clientId;
  @JsonKey(name: 'update_time')
  int updateTime;
  @JsonKey(name: 'create_time')
  int createTime;
  @JsonKey(name: 'img_url')
  String imgUrl;
  @JsonKey(name: 'web_url')
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

  factory AdListInfo.fromJson(Map<String, dynamic> json) =>
      _$AdListInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AdListInfoToJson(this);
}

///软文
@JsonSerializable()
class Article {
  String id;
  String title;
  String image;
  String thumbnail;
  String url;
  String contents;
  int status;
  @JsonKey(name: 'client_id')
  String clientId;
  @JsonKey(name: 'update_time')
  int updateTime;
  @JsonKey(name: 'create_time')
  int createTime;
  @JsonKey(name: 'is_web')
  bool isWeb;
  @JsonKey(name: 'category_id')
  String categoryId;
  @JsonKey(name: 'service_id')
  String serviceId;

  Article(
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

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}

///服务信息
@JsonSerializable()
class Service {
  String id;
  String title;
  String icon;
  @JsonKey(name: 'client_id')
  String clientId;
  @JsonKey(name: 'update_time')
  int updateTime;
  @JsonKey(name: 'create_time')
  int createTime;
  @JsonKey(name: 'category_id')
  String categoryId;

  Service(this.id, this.title, this.icon, this.clientId, this.updateTime,
      this.createTime, this.categoryId);

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}

@JsonSerializable()
class PhoneNumberInfo {
  String name;
  String phone;
  String des;

  PhoneNumberInfo({this.name, this.phone, this.des});

  factory PhoneNumberInfo.fromJson(Map<String, dynamic> json) =>
      _$PhoneNumberInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneNumberInfoToJson(this);
}

@JsonSerializable()
class UpdateInfo {
  String id;
  @JsonKey(name: 'verson')
  String version;
  String url;
  String introduction;
  @JsonKey(name: 'client_id')
  String clientId;
  @JsonKey(name: 'update_time')
  int updateTime;
  @JsonKey(name: 'create_time')
  int createTime;

  UpdateInfo(
      {this.id,
      this.version,
      this.url,
      this.introduction,
      this.clientId,
      this.updateTime,
      this.createTime});

  factory UpdateInfo.fromJson(Map<String, dynamic> json) =>
      _$UpdateInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateInfoToJson(this);
}

@JsonSerializable()
class ReportSt {
  int code;
  String info;

  ReportSt({this.code, this.info});

  factory ReportSt.fromJson(Map<String, dynamic> json) =>
      _$ReportStFromJson(json);

  Map<String, dynamic> toJson() => _$ReportStToJson(this);
}
