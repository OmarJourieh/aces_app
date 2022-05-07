import 'package:aces_app/models/user.dart';

class Comment {
  int? id;
  int? userId;
  int? postId;
  String? content;
  String? createdAt;
  String? updatedAt;
  User? user;

  Comment(
      {this.id,
      this.userId,
      this.postId,
      this.content,
      this.createdAt,
      this.updatedAt,
      this.user});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    postId = json['post_id'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['post_id'] = this.postId;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
