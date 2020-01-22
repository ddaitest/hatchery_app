import 'package:json_annotation/json_annotation.dart';

part 'beans.g.dart';

@JsonSerializable()
class Post {
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

  Post(this.id, this.title, this.summary, this.content, this.status,
      this.clientId, this.updateTime, this.createTime);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
