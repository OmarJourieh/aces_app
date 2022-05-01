import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int navigationIndex = 0;

  changeIndex({required int newIndex}) {
    navigationIndex = newIndex;
    notifyListeners();
  }
}
