import 'package:flutter/material.dart';

getAppBar({required String title}) {
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
  );
}
