import 'dart:convert';

import 'package:aces_app/constants/constants.dart';
import 'package:aces_app/models/comment.dart';
import 'package:aces_app/models/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForumProvider extends ChangeNotifier {
  Future<List<Post>> getAllPosts() async {
    var res = await http.get(
      Uri.parse('$baseAPI/getAllPosts'),
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      },
    );
    if (res.statusCode == 200) {
      String data = res.body;
      var jsonData = jsonDecode(data);
      Posts posts = Posts.fromjson(jsonData);
      List<Post> pList = posts.postList.map((e) => Post.fromJson(e)).toList();
      for (var item in pList) {
        print(item.content);
      }
      return pList;
    } else {
      print("statusCode=${res.statusCode}");
      List<Post> empty = [];
      return empty;
    }
  }

  Future<Post> getPostById({required int id}) async {
    var res = await http.get(
      Uri.parse('$baseAPI/getPostById/' + id.toString()),
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      },
    );
    Post post = Post.fromJson(jsonDecode(res.body)['post']);
    // print(post.comment!.length);
    notifyListeners();
    return post;
  }

  Future<void> addComment(Comment comment) async {
    http.Response res = await http.post(
      Uri.parse("$baseAPI/addComment"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(comment),
    );

    print("Response: ${res.body}");

    notifyListeners();
  }

  Future<void> addPost(Post post) async {
    http.Response res = await http.post(
      Uri.parse("$baseAPI/addPost"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(post),
    );

    print("Response: ${res.body}");

    notifyListeners();
  }

  Future<void> deleteComment({required int commentId}) async {
    http.Response res = await http.post(
      Uri.parse("$baseAPI/deleteComment/$commentId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({}),
    );
  }

  Future<void> deletePost({required int postId}) async {
    http.Response res = await http.post(
      Uri.parse("$baseAPI/deletePost/$postId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({}),
    );
  }
}
