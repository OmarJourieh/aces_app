import 'package:aces_app/widgets/my_app_bar.dart';
import 'package:aces_app/widgets/my_bottom_navbar.dart';
import 'package:flutter/material.dart';

class ForumScreen extends StatelessWidget {
  const ForumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getBottomNavBar(context),
      backgroundColor: Colors.white,
      appBar: getAppBar(title: "Community"),
      body: Center(
        child: Text("Forum Screen"),
      ),
    );
  }
}
