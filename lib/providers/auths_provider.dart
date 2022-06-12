import 'dart:convert';
import 'package:aces_app/constants/constants.dart';
import 'package:aces_app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import 'dart:async';

class AuthsProvider extends ChangeNotifier {
  String? token;
  User? user;

  bool get isAuth {
    return token != null;
  }

  Future<String> register(User user) async {
    try {
      http.Response res = await http.post(
        Uri.parse(baseAPI + "/register"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user),
      );
      return "success";
    } catch (e) {
      return "fail";
    }
  }

  Future<String> login(User user) async {
    print("Trying login!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    http.Response res = await http.post(
      Uri.parse(baseAPI + "/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user),
    );

    String data = jsonDecode(res.body)['token'];

    print("OK LOOK: $data");

    if (data == "fail") {
      print('fail');
      return "fail";
    } else {
      token = data;
      this.user = User.fromJson(jsonDecode(res.body)['user'][0]);
      notifyListeners();
      return "success";
    }
  }

  Future<void> logout() async {
    print("logout");
    token = null;
    user = null;
    notifyListeners();
  }
}
