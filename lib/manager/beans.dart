import 'package:json_annotation/json_annotation.dart';

///flutter pub run build_runner build


/// 物业公告

// class Notice {
//   String? id = "";
//   String title = "";
//   String summary = "";
//   String content = "";
//   num status = 1;
//   @JsonKey(name: 'client_id')
//   String clientId = "";
//   @JsonKey(name: 'update_time')
//   num updateTime = 0;
//
//   @JsonKey(name: 'create_time')
//   num createTime = 0;
//
//   Notice(this.id, this.title, this.summary, this.content, this.status,
//       this.clientId, this.updateTime, this.createTime);
//
//   factory Notice.fromJson(Map<String, dynamic> json) => _$NoticeFromJson(json);
//
//   Map<String, dynamic> toJson() => _$NoticeToJson(this);
// }
//
// /// Banner 信息
//
// class BannerInfo {
//   String id;
//   String description;
//   int status;
//
//   @JsonKey(name: 'client_id')
//   String clientId;
//   @JsonKey(name: 'update_time')
//   int updateTime;
//   @JsonKey(name: 'create_time')
//   int createTime;
//   @JsonKey(name: 'img_url')
//   String imgUrl;
//   @JsonKey(name: 'web_url')
//   String webUrl;
//   @JsonKey(name: 'category_id')
//   String categoryId;
//
//   BannerInfo(
//       {this.id,
//       this.description,
//       this.status,
//       this.clientId,
//       this.updateTime,
//       this.createTime,
//       this.imgUrl,
//       this.webUrl,
//       this.categoryId});
//
//   factory BannerInfo.fromJson(Map<String, dynamic> json) =>
//       _$BannerInfoFromJson(json);
//
//   Map<String, dynamic> toJson() => _$BannerInfoToJson(this);
// }
//
// ///广告信息
//
// class AdListInfo {
//   String id;
//   String description;
//   int status;
//   @JsonKey(name: 'client_id')
//   String clientId;
//   @JsonKey(name: 'update_time')
//   int updateTime;
//   @JsonKey(name: 'create_time')
//   int createTime;
//   @JsonKey(name: 'img_url')
//   String imgUrl;
//   @JsonKey(name: 'web_url')
//   String webUrl;
//
//   AdListInfo(
//       {this.id,
//       this.description,
//       this.status,
//       this.clientId,
//       this.updateTime,
//       this.createTime,
//       this.imgUrl,
//       this.webUrl});
//
//   factory AdListInfo.fromJson(Map<String, dynamic> json) =>
//       _$AdListInfoFromJson(json);
//
//   Map<String, dynamic> toJson() => _$AdListInfoToJson(this);
// }
//
// ///软文
// class ArticleDataInfo {
//   String id;
//   String avatar;
//   String title;
//   String contentsShort;
//   String contentsType;
//   String source;
//   String status;
//   String clientId;
//   String authorId;
//   String authorName;
//   String authorAvatar;
//   String redirectUrl;
//   String serviceId;
//   String createTime;
//   String updateTime;
//
//   ArticleDataInfo(
//       {this.id,
//       this.avatar,
//       this.title,
//       this.contentsShort,
//       this.contentsType,
//       this.source,
//       this.status,
//       this.clientId,
//       this.authorId,
//       this.authorName,
//       this.authorAvatar,
//       this.redirectUrl,
//       this.serviceId,
//       this.createTime,
//       this.updateTime});
//
//   ArticleDataInfo.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     avatar = json['avatar'];
//     title = json['title'];
//     contentsShort = json['contents_short'];
//     contentsType = json['contents_type'];
//     source = json['source'];
//     status = json['status'];
//     clientId = json['client_id'];
//     authorId = json['author_id'];
//     authorName = json['author_name'];
//     authorAvatar = json['author_avatar'];
//     redirectUrl = json['redirect_url'];
//     serviceId = json['service_id'];
//     createTime = json['create_time'];
//     updateTime = json['update_time'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['avatar'] = this.avatar;
//     data['title'] = this.title;
//     data['contents_short'] = this.contentsShort;
//     data['contents_type'] = this.contentsType;
//     data['source'] = this.source;
//     data['status'] = this.status;
//     data['client_id'] = this.clientId;
//     data['author_id'] = this.authorId;
//     data['author_name'] = this.authorName;
//     data['author_avatar'] = this.authorAvatar;
//     data['redirect_url'] = this.redirectUrl;
//     data['service_id'] = this.serviceId;
//     data['create_time'] = this.createTime;
//     data['update_time'] = this.updateTime;
//     return data;
//   }
// }
//
// ///服务信息
//
// class Service {
//   String id;
//   String title;
//   String icon;
//   @JsonKey(name: 'client_id')
//   String clientId;
//   @JsonKey(name: 'update_time')
//   int updateTime;
//   @JsonKey(name: 'create_time')
//   int createTime;
//   @JsonKey(name: 'category_id')
//   String categoryId;
//
//   Service(this.id, this.title, this.icon, this.clientId, this.updateTime,
//       this.createTime, this.categoryId);
//
//   factory Service.fromJson(Map<String, dynamic> json) =>
//       _$ServiceFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ServiceToJson(this);
// }
//
//
// class PhoneNumberInfo {
//   String name;
//   String phone;
//   String des;
//
//   PhoneNumberInfo({this.name, this.phone, this.des});
//
//   factory PhoneNumberInfo.fromJson(Map<String, dynamic> json) =>
//       _$PhoneNumberInfoFromJson(json);
//
//   Map<String, dynamic> toJson() => _$PhoneNumberInfoToJson(this);
// }
//
//
// class UpdateInfo {
//   String id;
//   @JsonKey(name: 'verson')
//   String version;
//   String url;
//   String introduction;
//   @JsonKey(name: 'client_id')
//   String clientId;
//   @JsonKey(name: 'update_time')
//   int updateTime;
//   @JsonKey(name: 'create_time')
//   int createTime;
//
//   UpdateInfo(
//       {this.id,
//       this.version,
//       this.url,
//       this.introduction,
//       this.clientId,
//       this.updateTime,
//       this.createTime});
//
//   factory UpdateInfo.fromJson(Map<String, dynamic> json) =>
//       _$UpdateInfoFromJson(json);
//
//   Map<String, dynamic> toJson() => _$UpdateInfoToJson(this);
// }
//
//
// class ReportSt {
//   int code;
//   String info;
//
//   ReportSt({this.code, this.info});
//
//   factory ReportSt.fromJson(Map<String, dynamic> json) =>
//       _$ReportStFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ReportStToJson(this);
// }
//
// class SerivceTopInfo {
//   String id;
//   String title;
//   String icon;
//   String clientId;
//   int updateTime;
//   int createTime;
//   String categoryId;
//
//   SerivceTopInfo(
//       {this.id,
//       this.title,
//       this.icon,
//       this.clientId,
//       this.updateTime,
//       this.createTime,
//       this.categoryId});
//
//   SerivceTopInfo.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     icon = json['icon'];
//     clientId = json['client_id'];
//     updateTime = json['update_time'];
//     createTime = json['create_time'];
//     categoryId = json['category_id'];
//   }
// }
