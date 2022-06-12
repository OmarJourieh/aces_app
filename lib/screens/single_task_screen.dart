import 'package:aces_app/models/step.dart';
import 'package:aces_app/view_models/steps_view_model.dart';
import 'package:aces_app/view_models/tasks_view_model.dart';
import 'package:aces_app/widgets/app_error.dart';
import 'package:aces_app/widgets/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleTaskScreen extends StatelessWidget {
  SingleTaskScreen({Key? key}) : super(key: key);
  static const routeName = '/singleTaskScreen';
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    StpsViewModel stepsViewModel = context.watch<StpsViewModel>();
    TasksViewModel tasksViewModel = context.watch<TasksViewModel>();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/grape.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              tasksViewModel.selectedTask?.title ?? '', //replace this
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: _ui(stepsViewModel, width, tasksViewModel),
    );
  }

  _ui(StpsViewModel stepsViewModel, width, tasksViewModel) {
    if (stepsViewModel.loading) {
      return AppLoading();
    }
    if (stepsViewModel.stepError != null) {
      return AppError(
        errortxt: stepsViewModel.stepError?.message,
      );
    }
    return ListView.builder(
        itemCount: stepsViewModel.stepListModel.length,
        itemBuilder: (BuildContext context, int index) {
          if (stepsViewModel.stepListModel.length - 1 > index &&
              stepsViewModel.stepListModel[index].duration ==
                  stepsViewModel.stepListModel[index + 1].duration &&
              flag == false) {
            flag = true;
            return _getMultiItemChild(
              step1: stepsViewModel.stepListModel[index],
              step2: stepsViewModel.stepListModel[index + 1],
              tasksViewModel: tasksViewModel,
            );
          } else if (flag == false &&
              stepsViewModel.stepListModel.length - 1 >= index) {
            return _getSingleItemChild(
              width: width,
              step: stepsViewModel.stepListModel[index],
              tasksViewModel: tasksViewModel,
            );
          } else {
            flag = false;
            return Divider();
          }
        });
  }

  _getSingleItemChild(
      {required width,
      required Stepe step,
      required TasksViewModel tasksViewModel}) {
    return Container(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Week ${step.duration}", //replace this
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              print("This click takes you to the step's page");
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/images/placeholder.png"), //replace this
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                  ),
                  child: Text(
                      tasksViewModel.selectedTask?.title ?? ''), //replace this
                ),
                const SizedBox(height: 5),
                Text(
                  step.title ?? '',
                  style: TextStyle(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Read more",
                  style: TextStyle(
                    color: Colors.green[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _getMultiItemChild(
      {required Stepe step1,
      required Stepe step2,
      required TasksViewModel tasksViewModel}) {
    return Container(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Week ${step1.duration}", //replace this
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          // const Text(
          //   " 1 - 8 MAY", //replace this
          //   style: TextStyle(
          //     fontSize: 14,
          //   ),
          // ),
          GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 5,
              mainAxisExtent: 220,
            ),
            children: [
              _gridItem(step: step1, tasksViewModel: tasksViewModel),
              _gridItem(step: step2, tasksViewModel: tasksViewModel),
            ],
            padding: const EdgeInsets.all(10),
            shrinkWrap: true,
          ),
        ],
      ),
    );
  }

  //this will be called for each child of GridView (add parameters as needed)
  _gridItem({required Stepe step, required TasksViewModel tasksViewModel}) {
    return InkWell(
      onTap: () {
        print("This click takes you to the step's page");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage("assets/images/placeholder.png"), //replace this
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.green[100],
            ),
            child:
                Text(tasksViewModel.selectedTask?.title ?? ''), //replace this
          ),
          const SizedBox(height: 5),
          Text(
            step.title ?? '',
            style: const TextStyle(),
          ),
          const SizedBox(
            height: 13,
          ),
          Text(
            "Read more",
            style: TextStyle(
              color: Colors.green[900],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
