// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notice _$NoticeFromJson(Map<String, dynamic> json) {
  return Notice(
    json['id'] as String,
    json['avatar'] as String,
    json['title'] as String,
    json['contents_short'] as String,
    json['contents_type'] as String,
    json['source'] as String,
    json['status'] as String,
    json['client_id'] as String,
    json['redirect_url'] as String,
    json['update_time'] as String,
    json['create_time'] as String,
  );
}

Map<String, dynamic> _$NoticeToJson(Notice instance) => <String, dynamic>{
      'id': instance.id,
      'avatar': instance.image,
      'title': instance.title,
      'contents_short': instance.summary,
      'contents_type': instance.contentType,
      'source': instance.source,
      'status': instance.status,
      'client_id': instance.clientId,
      'redirect_url': instance.redirectUrl,
      'update_time': instance.updateTime,
      'create_time': instance.createTime,
    };

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
    json['id'] as String,
    json['avatar'] as String,
    json['title'] as String,
    json['contents_short'] as String,
    json['contents_type'] as String,
    json['source'] as String,
    json['status'] as String,
    json['client_id'] as String,
    json['redirect_url'] as String,
    json['update_time'] as String,
    json['create_time'] as String,
  );
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'id': instance.id,
      'avatar': instance.image,
      'title': instance.title,
      'contents_short': instance.summary,
      'contents_type': instance.contentType,
      'source': instance.source,
      'status': instance.status,
      'client_id': instance.clientId,
      'redirect_url': instance.redirectUrl,
      'update_time': instance.updateTime,
      'create_time': instance.createTime,
    };

BannerInfo _$BannerInfoFromJson(Map<String, dynamic> json) {
  return BannerInfo(
    json['id'] as String,
    json['avatar'] as String,
    json['redirect_url'] as String,
    json['update_time'] as String,
    json['create_time'] as String,
  );
}

Map<String, dynamic> _$BannerInfoToJson(BannerInfo instance) => <String, dynamic>{
      'id': instance.id,
      'avatar': instance.image,
      'redirect_url': instance.redirectUrl,
      'update_time': instance.updateTime,
      'create_time': instance.createTime,
    };

Advertising _$AdvertisingFromJson(Map<String, dynamic> json) {
  return Advertising(
    json['id'] as String,
    json['avatar'] as String,
    json['redirect_url'] as String,
    json['update_time'] as String,
    json['create_time'] as String,
  );
}

Map<String, dynamic> _$AdvertisingToJson(Advertising instance) =>
    <String, dynamic>{
      'id': instance.id,
      'avatar': instance.image,
      'redirect_url': instance.redirectUrl,
      'update_time': instance.updateTime,
      'create_time': instance.createTime,
    };

Contact _$ContactFromJson(Map<String, dynamic> json) {
  return Contact(
    json['id'] as String,
    json['name'] as String,
    json['phone'] as String,
    json['contents_short'] as String,
  );
}

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'contents_short': instance.content,
    };

Feedback _$FeedbackFromJson(Map<String, dynamic> json) {
  return Feedback(
    json['id'] as String,
    json['title'] as String,
    json['contents'] as String,
    json['user_phone'] as String,
    json['img1'] as String,
    json['img2'] as String,
    json['img3'] as String,
    json['img4'] as String,
    json['img5'] as String,
    json['img6'] as String,
  );
}

Map<String, dynamic> _$FeedbackToJson(Feedback instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'contents': instance.contents,
      'user_phone': instance.phone,
      'img1': instance.img1,
      'img2': instance.img2,
      'img3': instance.img3,
      'img4': instance.img4,
      'img5': instance.img5,
      'img6': instance.img6,
    };
