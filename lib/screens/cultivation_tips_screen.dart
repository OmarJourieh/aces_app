import 'package:aces_app/screens/single_task_screen.dart';
import 'package:aces_app/utils/navigation_utils.dart';
import 'package:aces_app/view_models/steps_view_model.dart';
import 'package:aces_app/view_models/tasks_view_model.dart';
import 'package:aces_app/widgets/app_error.dart';
import 'package:aces_app/widgets/app_loading.dart';
import 'package:aces_app/widgets/category_card.dart';
import 'package:aces_app/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CultivationTips extends StatelessWidget {
  const CultivationTips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TasksViewModel tasksViewModel = context.watch<TasksViewModel>();
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height * .45,

            decoration: const BoxDecoration(
              color: Color(0xFFF5CEB8),
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                image: AssetImage("assets/images/undraw_pilates_gpdb.png"),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      alignment: Alignment.center,
                      height: 52,
                      width: 52,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF2BEA1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset("assets/icons/menu.svg"),
                    ),
                  ),
                  Text(
                    "Good Mornign \nShishir",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  const SearchBar(),
                  _ui(tasksViewModel),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _ui(TasksViewModel tasksViewModel) {
    if (tasksViewModel.loading) {
      return AppLoading();
    }
    if (tasksViewModel.userError != null) {
      return AppError(
        errortxt: tasksViewModel.userError?.message,
      );
    }
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .85,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: tasksViewModel.taskListModel.length,
        itemBuilder: (context, index) {
          return CategoryCard(
            title: tasksViewModel.taskListModel[index].title!,
            svgSrc: "assets/images/strawberry.png",
            press: () async {
              tasksViewModel
                  .setSelectedTask(tasksViewModel.taskListModel[index]);
              context
                  .read<StpsViewModel>()
                  .getStps(tasksViewModel.taskListModel[index].id.toString());
              openTaskDetails(context, SingleTaskScreen.routeName);
            },
          );
        },
      ),
    );
  }
}
