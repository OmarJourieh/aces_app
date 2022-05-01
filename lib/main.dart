import 'package:aces_app/providers/diseases_provider.dart';
import 'package:aces_app/providers/navigation_provider.dart';
import 'package:aces_app/providers/plants_provider.dart';
import 'package:aces_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlantsProvider()),
        ChangeNotifierProvider(create: (context) => DiseasesProvider()),
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
