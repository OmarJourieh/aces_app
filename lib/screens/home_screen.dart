import 'package:aces_app/models/plant.dart';
import 'package:aces_app/screens/single_plant_screen.dart';
import 'package:aces_app/view_models/plants_view_model.dart';
import 'package:aces_app/widgets/app_error.dart';
import 'package:aces_app/widgets/app_loading.dart';
import 'package:aces_app/widgets/my_app_bar.dart';
import 'package:aces_app/widgets/my_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 3000))
          ..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    PlantsViewModel plantViewModel = context.watch<PlantsViewModel>();
    return Scaffold(
      bottomNavigationBar: getBottomNavBar(context),
      backgroundColor: Colors.white,
      appBar: getAppBar(title: "ACES", context: context),
      body: _ui(height, width, plantViewModel),
    );
  }

  _ui(height, width, PlantsViewModel plantViewModel) {
    if (plantViewModel.loading) {
      return AppLoading();
    }
    if (plantViewModel.plantError != null) {
      return AppError(
        errortxt: plantViewModel.plantError?.message,
      );
    }
    return SingleChildScrollView(
      child: SizedBox(
        height: height,
        child: Column(
          children: [
            SizedBox(
              height: height * 0.2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: plantViewModel.plantListModel.length,
                itemBuilder: (context, index) {
                  return plantViewModel.selectedplant?.id ==
                          plantViewModel.plantListModel[index].id
                      ? _displayPlant2(
                          index: index,
                          plantViewModel: plantViewModel,
                          name: plantViewModel.plantListModel[index].name ?? '',
                          image: "assets/images/apple.png",
                          width: width,
                          height: height,
                          context: context,
                          plant: Plant(
                            id: plantViewModel.plantListModel[index].id,
                            name: plantViewModel.plantListModel[index].name,
                            description: plantViewModel
                                .plantListModel[index].description,
                            image: "assets/images/apple.png",
                          ),
                        )
                      : _displayPlant(
                          plantViewModel: plantViewModel,
                          index: index,
                          name: plantViewModel.plantListModel[index].name ?? '',
                          image: "assets/images/apple.png",
                          width: width,
                          height: height,
                          context: context,
                          plant: Plant(
                            id: plantViewModel.plantListModel[index].id,
                            name: plantViewModel.plantListModel[index].name,
                            description: plantViewModel
                                .plantListModel[index].description,
                            image: "assets/images/apple.png",
                          ),
                        );
                },
              ),
            ),
            Container(
                height: height * 0.2,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        margin: const EdgeInsets.all(20),
                        child: InkWell(
                          child: Column(
                            children: [
                              Container(
                                height: height * 0.12,
                                width: width * 0.4,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/fertilizer_calculator.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const Text("Fertilizer Calculator"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        margin: const EdgeInsets.all(20),
                        child: InkWell(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: height * 0.12,
                                width: width * 0.4,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/plant_diseases.png"),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                              const Text("Pests & Diseases"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: height * 0.3,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text(
                        "Heal your crop",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      // border: Border.all(
                      //     // color: Colors.red,
                      //     ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: height * 0.07,
                                    width: width * 0.14,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/take_photo.png"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Text("Take a photo"),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right,
                              size: 30,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: height * 0.07,
                                    width: width * 0.14,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/diagnose.png"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Text("Get Diagnosis"),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right,
                              size: 30,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: height * 0.07,
                                    width: width * 0.14,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/cure.png"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Text("Get Treatment"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {},
                                  child: const Text("Take a picture"),
                                  style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor: Colors.blue[700],
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      // side: BorderSide(color: Colors.red),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text(
                        "Weather",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(plantViewModel.weather?.city ?? ''),
                          const SizedBox(height: 5),
                          Text(
                            "${plantViewModel.weather?.temp?.toStringAsFixed(1)} C",
                            style: const TextStyle(
                              fontSize: 35,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            plantViewModel.timeNow!,
                            style: TextStyle(
                              // fontSize: 35,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/sunny.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Clear throughout the day.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "0%",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _displayPlant2(
      {required int index,
      required String image,
      required String name,
      required double width,
      required double height,
      required Plant plant,
      required context,
      required PlantsViewModel plantViewModel}) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => SinglePlantScreen(plant: plant),
          ),
        );
      },
      onLongPress: () {
        setState(() {
          plantViewModel.setSelectedPlant(plantViewModel.plantListModel[index]);
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        width: width * 0.3,
        // height: 100,
        child: Column(
          children: [
            RotationTransition(
              turns: _animation,
              child: Container(
                height: height * 0.1,
                width: width * 0.2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  _displayPlant({
    required String image,
    required String name,
    required double width,
    required double height,
    required Plant plant,
    required context,
    required PlantsViewModel plantViewModel,
    required int index,
  }) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => SinglePlantScreen(plant: plant),
          ),
        );
      },
      onLongPress: () {
        setState(() {
          plantViewModel.setSelectedPlant(plantViewModel.plantListModel[index]);
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        width: width * 0.3,
        // height: 100,
        child: Column(
          children: [
            Container(
              height: height * 0.1,
              width: width * 0.2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
