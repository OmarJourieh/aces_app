import 'package:aces_app/models/plant.dart';
import 'package:aces_app/providers/plants_provider.dart';
import 'package:aces_app/screens/single_plant_screen.dart';
import 'package:aces_app/widgets/my_app_bar.dart';
import 'package:aces_app/widgets/my_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: getBottomNavBar(context),
      backgroundColor: Colors.white,
      appBar: getAppBar(title: "ACES", context: context),
      body: FutureBuilder(
        future: Provider.of<PlantsProvider>(context).getAllPlants(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: height,
              child: Column(
                children: [
                  Container(
                    height: height * 0.2,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return _displayPlant(
                          name: snapshot.data[index].name,
                          image: "assets/images/apple.png",
                          width: width,
                          height: height,
                          context: context,
                          plant: Plant(
                            id: snapshot.data[index].id,
                            name: snapshot.data[index].name,
                            description: snapshot.data[index].description,
                            image: "assets/images/apple.png",
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: height * 0.3,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Heal your crop",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            // border: Border.all(
                            //     // color: Colors.red,
                            //     ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 20),
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
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/take_photo.png"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Text("Take a photo"),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    size: 30,
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          height: height * 0.07,
                                          width: width * 0.14,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/diagnose.png"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Text("Get Diagnosis"),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    size: 30,
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          height: height * 0.07,
                                          width: width * 0.14,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/cure.png"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Text("Get Treatment"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Text("Take a picture"),
                                        style: TextButton.styleFrom(
                                          primary: Colors.white,
                                          backgroundColor: Colors.blue[700],
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
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
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Weather",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Damascus, 14 Apr"),
                                SizedBox(height: 5),
                                Text(
                                  "25.5 C",
                                  style: TextStyle(
                                    fontSize: 35,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Sunset 7:06 PM",
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
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/sunny.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.green[900],
              ),
            );
          }
        },
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
  }) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => SinglePlantScreen(plant: plant),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
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
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
