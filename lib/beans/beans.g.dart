// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beans.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
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

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'summary': instance.summary,
      'content': instance.content,
      'status': instance.status,
      'client_id': instance.clientId,
      'update_time': instance.updateTime,
      'create_time': instance.createTime,
    };
