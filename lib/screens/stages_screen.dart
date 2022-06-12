import 'package:aces_app/models/stage.dart';
import 'package:aces_app/models/step.dart';
import 'package:aces_app/view_models/stage_view_model.dart';
import 'package:aces_app/widgets/app_error.dart';
import 'package:aces_app/widgets/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StagesScreen extends StatelessWidget {
  StagesScreen({Key? key}) : super(key: key);
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    StagesViewModel stagViewModel = context.watch<StagesViewModel>();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
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
            const Text(
              "Planting", //replace this
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: _ui(stagViewModel, width),
      ),
    );
  }

  _ui(StagesViewModel stagViewModel, width) {
    if (stagViewModel.loading) {
      return AppLoading();
    }
    if (stagViewModel.stageError != null) {
      return AppError(
        errortxt: stagViewModel.stageError?.message,
      );
    }
    return ListView.builder(
        itemCount: stagViewModel.stageListModel.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return _getStageCard(
              stagViewModel: stagViewModel,
              status: "Past",
              stageName: stagViewModel.stageListModel[index].name,
              width: width,
              timeDescription:
                  "${stagViewModel.stageListModel[index].interval} weeks",
              stage: stagViewModel.stageListModel[index]);
        });
  }

  _getStageCard({
    required status,
    required stageName,
    required timeDescription,
    required Stage stage,
    required width,
    required StagesViewModel stagViewModel,
  }) {
    return Container(
      decoration: BoxDecoration(color: Colors.green[100]),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            color: Colors.white,
            child: Text(status), // 'past' or 'ongoing' or 'upcoming'
          ),
          const SizedBox(height: 10),
          Text(stageName),
          const SizedBox(height: 10),
          Text(
            timeDescription,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Column(
            children: [
              ...List.generate(stage.steps?.length ?? 0, (index) {
                if (stage.steps!.length - 1 > index &&
                    stage.steps?[index].interval ==
                        stage.steps?[index + 1].interval &&
                    stagViewModel.listStep.isEmpty) {
                  for (int i = index; i <= stage.steps!.length - 1; i++) {
                    if (stage.steps!.length - 1 > i &&
                        stage.steps?[i].interval ==
                            stage.steps?[i + 1].interval) {
                      stagViewModel.listStep.add(stage.steps![i]);
                    } else {
                      stagViewModel.listStep.add(stage.steps![i]);
                      break;
                    }
                  }

                  ///!!
                  return _getMultiItemChild(stepp: stagViewModel.listStep);
                } else if (stage.steps!.length - 1 >= index &&
                    stagViewModel.listStep.isEmpty) {
                  return _getSingleItemChild(
                      width: width, stepp: stage.steps![index]);
                } else if (stagViewModel.listStep.isNotEmpty) {
                  stagViewModel.listStep.removeLast();
                  if (stagViewModel.listStep.length == 1) {
                    stagViewModel.listStep.removeLast();
                  }
                  return const SizedBox.shrink();
                } else {
                  return const SizedBox.shrink();
                }
              }),
            ],
          )
        ],
      ),
    );
  }

  _getSingleItemChild({required width, required Stepe stepp}) {
    return Container(
      padding: const EdgeInsets.all(18),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Week ${stepp.interval}", //replace this
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            " 29 MAY - 5 JUN", //replace this
            style: TextStyle(
              fontSize: 14,
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
                  child: const Text("Planting"), //replace this
                ),
                const SizedBox(height: 5),
                Text(
                  stepp.title ?? '',
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

  _getMultiItemChild({required List<Stepe> stepp}) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${stepp.last.interval} week ", //replace this
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            " 1 - 8 MAY", //replace this
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 5,
              mainAxisExtent: 220,
            ),
            children: [
              ...stepp.map((e) {
                return _gridItem(stepp: e);
              }).toList()
            ],
            padding: EdgeInsets.all(10),
            shrinkWrap: true,
          ),
        ],
      ),
    );
  }

  //this will be called for each child of GridView (add parameters as needed)
  _gridItem({required Stepe stepp}) {
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
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.green[100],
            ),
            child: Text("Planting"), //replace this
          ),
          const SizedBox(height: 5),
          Text(
            stepp.title ?? '',
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
    );
  }
}
