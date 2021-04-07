import 'package:json_annotation/json_annotation.dart';

part 'entity.g.dart';

///flutter pub run build_runner build

/// 物业公告
@JsonSerializable()
class Notice {
  String id = "";

  @JsonKey(name: 'avatar')
  String image = "";

  String title = "";

  @JsonKey(name: 'contents_short')
  String summary = "";

  @JsonKey(name: 'contents_type')
  String contentType = "0";

  String source = "";

  String status = "";

  @JsonKey(name: 'client_id')
  String clientId = "";

  @JsonKey(name: 'redirect_url')
  String redirectUrl = "";

  @JsonKey(name: 'update_time')
  String updateTime = "0";

  @JsonKey(name: 'create_time')
  String createTime = "0";

  Notice(
      this.id,
      this.image,
      this.title,
      this.summary,
      this.contentType,
      this.source,
      this.status,
      this.clientId,
      this.redirectUrl,
      this.updateTime,
      this.createTime);

  factory Notice.fromJson(Map<String, dynamic> json) => _$NoticeFromJson(json);

  Map<String, dynamic> toJson() => _$NoticeToJson(this);
}

/// 软文
@JsonSerializable()
class Article {
  String id = "";

  @JsonKey(name: 'avatar')
  String image = "";

  String title = "";

  @JsonKey(name: 'contents_short')
  String summary = "";

  @JsonKey(name: 'contents_type')
  String contentType = "0";

  String source = "";

  String status = "";

  @JsonKey(name: 'client_id')
  String clientId = "";

  @JsonKey(name: 'redirect_url')
  String redirectUrl = "";

  @JsonKey(name: 'update_time')
  String updateTime = "0";

  @JsonKey(name: 'create_time')
  String createTime = "0";

  Article(
      this.id,
      this.image,
      this.title,
      this.summary,
      this.contentType,
      this.source,
      this.status,
      this.clientId,
      this.redirectUrl,
      this.updateTime,
      this.createTime);

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}

/// Banner
@JsonSerializable()
class BannerInfo {
  String id = "";

  @JsonKey(name: 'avatar')
  String image = "";

  @JsonKey(name: 'redirect_url')
  String redirectUrl = "";

  @JsonKey(name: 'update_time')
  String updateTime = "0";

  @JsonKey(name: 'create_time')
  String createTime = "0";

  BannerInfo(
      this.id, this.image, this.redirectUrl, this.updateTime, this.createTime);

  factory BannerInfo.fromJson(Map<String, dynamic> json) => _$BannerInfoFromJson(json);

  Map<String, dynamic> toJson() => _$BannerInfoToJson(this);
}

/// Banner
@JsonSerializable()
class Advertising {
  String id = "";

  @JsonKey(name: 'avatar')
  String image = "";

  @JsonKey(name: 'redirect_url')
  String redirectUrl = "";

  @JsonKey(name: 'update_time')
  String updateTime = "0";

  @JsonKey(name: 'create_time')
  String createTime = "0";

  Advertising(
      this.id, this.image, this.redirectUrl, this.updateTime, this.createTime);

  factory Advertising.fromJson(Map<String, dynamic> json) =>
      _$AdvertisingFromJson(json);

  Map<String, dynamic> toJson() => _$AdvertisingToJson(this);
}

/// Banner
@JsonSerializable()
class Contact {
  String id = "";

  String name = "";

  String phone = "";

  @JsonKey(name: 'contents_short')
  String content = "0";

  Contact(this.id, this.name, this.phone, this.content);

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);

  Map<String, dynamic> toJson() => _$ContactToJson(this);
}

/// 问题反馈 + 报事报修
@JsonSerializable()
class Feedback {
  String id = "";

  String title = "";

  String contents = "";

  @JsonKey(name: 'user_phone')
  String phone = "";

  String img1 = "";
  String img2 = "";
  String img3 = "";
  String img4 = "";
  String img5 = "";
  String img6 = "";

  Feedback(this.id, this.title, this.contents, this.phone, this.img1, this.img2,
      this.img3, this.img4, this.img5, this.img6);

  factory Feedback.fromJson(Map<String, dynamic> json) =>
      _$FeedbackFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackToJson(this);
}
