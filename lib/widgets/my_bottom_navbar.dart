import 'package:aces_app/providers/navigation_provider.dart';
import 'package:aces_app/screens/forum_screen.dart';
import 'package:aces_app/screens/home_screen.dart';
import 'package:aces_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

getBottomNavBar(context) {
  return BottomNavigationBar(
    currentIndex:
        Provider.of<NavigationProvider>(context, listen: true).navigationIndex,
    onTap: (newIndex) {
      Provider.of<NavigationProvider>(context, listen: false)
          .changeIndex(newIndex: newIndex);
      switch (newIndex) {
        case 0:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => HomeScreen(),
            ),
          );
          break;
        case 1:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => ForumScreen(),
            ),
          );
          break;
        case 2:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => ProfileScreen(),
            ),
          );
          break;
      }
    },
    selectedItemColor: Colors.green[900],
    unselectedItemColor: Colors.grey[400],
    backgroundColor: Colors.white,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: Icon(Icons.grass),
        ),
        label: 'Crops',
      ),
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: Icon(Icons.comment_rounded),
        ),
        label: 'Community',
      ),
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: Icon(Icons.person),
        ),
        label: 'You',
      ),
    ],
  );
}
