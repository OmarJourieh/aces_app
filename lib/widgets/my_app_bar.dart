import 'package:aces_app/providers/auths_provider.dart';
import 'package:aces_app/providers/navigation_provider.dart';
import 'package:aces_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

getAppBar({
  required String title,
  bool logoutButton = false,
  required context,
}) {
  return AppBar(
    iconTheme: IconThemeData(
      color: Colors.grey[800], //change your color here
    ),
    backgroundColor: Colors.white,
    elevation: 1,
    title: Text(
      title,
      style: TextStyle(color: Colors.black),
    ),
    actions: logoutButton == true
        ? [
            IconButton(
              onPressed: () async {
                await Provider.of<AuthsProvider>(context, listen: false)
                    .logout();
                Provider.of<NavigationProvider>(context, listen: false)
                    .navigationIndex = 0;
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => HomeScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.logout,
              ),
            ),
          ]
        : [],
  );
}
