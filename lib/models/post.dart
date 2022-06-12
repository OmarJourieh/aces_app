import 'package:aces_app/models/comment.dart';
import 'package:aces_app/models/user.dart';

class Post {
  int? id;
  int? userId;
  String? title;
  String? content;
  String? createdAt;
  String? updatedAt;
  User? user;
  List<Comment>? comment;

  Post(
      {this.id,
      this.userId,
      this.title,
      this.content,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.comment});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['comments'] != null) {
      comment = <Comment>[];
      json['comments'].forEach((v) {
        comment!.add(new Comment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.comment != null) {
      data['comments'] = this.comment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Posts {
  final List<dynamic> postList;

  Posts({required this.postList});

  factory Posts.fromjson(dynamic jsonData) {
    return Posts(
      postList: jsonData['post'],
    );
  }
}
