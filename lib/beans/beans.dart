import 'package:json_annotation/json_annotation.dart';

part 'beans.g.dart';

@JsonSerializable()
class Post {
  String id = "";
  String title = "";
  String summary = "";
  String content = "";
  num status = 1;
  String client_id = "";
  num update_time = 0;
  num create_time = 0;

  Post(this.id, this.title, this.summary, this.content, this.status,
      this.client_id, this.update_time, this.create_time);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
