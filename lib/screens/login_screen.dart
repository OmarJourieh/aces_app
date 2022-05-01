import 'package:aces_app/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "Welcome Back"),
      body: Center(
        child: Text("Login Screen"),
      ),
    );
  }
}
