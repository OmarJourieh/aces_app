import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aces_app/view_models/tasks_view_model.dart';

class TaskDetail extends StatelessWidget {
  const TaskDetail({Key? key}) : super(key: key);
  static const routeName = '/taskDetail';
  @override
  Widget build(BuildContext context) {
    TasksViewModel usersViewModel = context.watch<TasksViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text("hiii"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5.0),
            Text(
              usersViewModel.selectedTask!.title!,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 5.0),
          ],
        ),
      ),
    );
  }
}
