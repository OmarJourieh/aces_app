import 'dart:convert';

import 'package:aces_app/constants/constants.dart';
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
}
