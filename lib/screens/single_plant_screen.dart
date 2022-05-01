import 'package:aces_app/models/plant.dart';
import 'package:aces_app/screens/home_screen.dart';
import 'package:aces_app/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class SinglePlantScreen extends StatelessWidget {
  final Plant plant;
  const SinglePlantScreen({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: getAppBar(title: plant.name!),
      body: ListView(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width * 0.7,
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      plant.description!,
                    ),
                  ],
                ),
              ),
              Container(
                height: width * 0.3,
                width: width * 0.3,
                child: Image.asset("assets/images/apple.png"),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Diseases",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            height: height * 0.5,
            child: ListView(
              children: [
                _getDiseaseRow(
                  text:
                      "Black rot is caused by the fungus Diplodia seriata (syn Botryosphaeria obtusa). The fungus can infect dead tissue as well as living trunks, branches, leaves and fruits. The black rot fungi survive Minnesota winters in branch cankers and mummified fruit (shriveled and dried fruit) attached to the tree.",
                  name: "Black Rot",
                  callback: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => HomeScreen()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getDiseaseRow({required text, required name, required callback}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: ListTile(
        onTap: callback,
        title: Text(name),
        subtitle: Container(
          padding: EdgeInsets.only(top: 2),
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}
