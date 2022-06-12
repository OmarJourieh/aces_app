import 'package:aces_app/constants/constants.dart';
import 'package:aces_app/providers/auths_provider.dart';
import 'package:aces_app/providers/forum_provider.dart';
import 'package:aces_app/providers/navigation_provider.dart';

import 'package:aces_app/screens/single_task_screen.dart';
import 'package:aces_app/screens/stages_screen.dart';
import 'package:aces_app/screens/task_detail.dart';
import 'package:aces_app/view_models/plants_view_model.dart';
import 'package:aces_app/view_models/tasks_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_models/stage_view_model.dart';
import 'view_models/steps_view_model.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => PlantsViewModel()),
          ChangeNotifierProvider(create: (context) => NavigationProvider()),
          ChangeNotifierProvider(create: (context) => AuthsProvider()),
          ChangeNotifierProvider(create: (context) => ForumProvider()),
          ChangeNotifierProvider(create: (context) => TasksViewModel()),
          ChangeNotifierProvider(create: (context) => StpsViewModel()),
          ChangeNotifierProvider(create: (context) => StagesViewModel()),
        ],
        child: Builder(
          builder: (context) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: "Cairo",
              scaffoldBackgroundColor: kBackgroundColor,
              textTheme:
                  Theme.of(context).textTheme.apply(displayColor: kTextColor),
            ),
            home: const MyApp(),
            routes: {
              TaskDetail.routeName: (_) => const TaskDetail(),
              SingleTaskScreen.routeName: (_) => SingleTaskScreen(),
            },
          ),
        )),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StagesScreen();
  }
}
