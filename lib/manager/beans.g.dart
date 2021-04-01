// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beans.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notice _$NoticeFromJson(Map<String, dynamic> json) {
  return Notice(
    json['id'] as String,
    json['title'] as String,
    json['summary'] as String,
    json['content'] as String,
    json['status'] as num,
    json['client_id'] as String,
    json['update_time'] as num,
    json['create_time'] as num,
  );
}

Map<String, dynamic> _$NoticeToJson(Notice instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'summary': instance.summary,
      'content': instance.content,
      'status': instance.status,
      'client_id': instance.clientId,
      'update_time': instance.updateTime,
      'create_time': instance.createTime,
    };

BannerInfo _$BannerInfoFromJson(Map<String, dynamic> json) {
  return BannerInfo(
    id: json['id'] as String,
    description: json['description'] as String,
    status: json['status'] as int,
    clientId: json['client_id'] as String,
    updateTime: json['update_time'] as int,
    createTime: json['create_time'] as int,
    imgUrl: json['img_url'] as String,
    webUrl: json['web_url'] as String,
    categoryId: json['category_id'] as String,
  );
}

Map<String, dynamic> _$BannerInfoToJson(BannerInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'status': instance.status,
      'client_id': instance.clientId,
      'update_time': instance.updateTime,
      'create_time': instance.createTime,
      'img_url': instance.imgUrl,
      'web_url': instance.webUrl,
      'category_id': instance.categoryId,
    };

AdListInfo _$AdListInfoFromJson(Map<String, dynamic> json) {
  return AdListInfo(
    id: json['id'] as String,
    description: json['description'] as String,
    status: json['status'] as int,
    clientId: json['client_id'] as String,
    updateTime: json['update_time'] as int,
    createTime: json['create_time'] as int,
    imgUrl: json['img_url'] as String,
    webUrl: json['web_url'] as String,
  );
}

Map<String, dynamic> _$AdListInfoToJson(AdListInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'status': instance.status,
      'client_id': instance.clientId,
      'update_time': instance.updateTime,
      'create_time': instance.createTime,
      'img_url': instance.imgUrl,
      'web_url': instance.webUrl,
    };

Service _$ServiceFromJson(Map<String, dynamic> json) {
  return Service(
    json['id'] as String,
    json['title'] as String,
    json['icon'] as String,
    json['client_id'] as String,
    json['update_time'] as int,
    json['create_time'] as int,
    json['category_id'] as String,
  );
}

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'icon': instance.icon,
      'client_id': instance.clientId,
      'update_time': instance.updateTime,
      'create_time': instance.createTime,
      'category_id': instance.categoryId,
    };

PhoneNumberInfo _$PhoneNumberInfoFromJson(Map<String, dynamic> json) {
  return PhoneNumberInfo(
    name: json['name'] as String,
    phone: json['phone'] as String,
    des: json['des'] as String,
  );
}

Map<String, dynamic> _$PhoneNumberInfoToJson(PhoneNumberInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'des': instance.des,
    };

UpdateInfo _$UpdateInfoFromJson(Map<String, dynamic> json) {
  return UpdateInfo(
    id: json['id'] as String,
    version: json['verson'] as String,
    url: json['url'] as String,
    introduction: json['introduction'] as String,
    clientId: json['client_id'] as String,
    updateTime: json['update_time'] as int,
    createTime: json['create_time'] as int,
  );
}

Map<String, dynamic> _$UpdateInfoToJson(UpdateInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'verson': instance.version,
      'url': instance.url,
      'introduction': instance.introduction,
      'client_id': instance.clientId,
      'update_time': instance.updateTime,
      'create_time': instance.createTime,
    };

ReportSt _$ReportStFromJson(Map<String, dynamic> json) {
  return ReportSt(
    code: json['code'] as int,
    info: json['info'] as String,
  );
}

Map<String, dynamic> _$ReportStToJson(ReportSt instance) => <String, dynamic>{
      'code': instance.code,
      'info': instance.info,
    };
