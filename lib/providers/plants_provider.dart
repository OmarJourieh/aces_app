import 'dart:convert';

import 'package:aces_app/constants/constants.dart';
import 'package:aces_app/models/plant.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class PlantsProvider extends ChangeNotifier {
  Future<List<Plant>> getAllPlants() async {
    var res = await http.get(
      Uri.parse('$baseAPI/getAllPlants'),
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      },
    );
    if (res.statusCode == 200) {
      String data = res.body;
      var jsonData = jsonDecode(data);
      Plants plants = Plants.fromjson(jsonData);
      List<Plant> pList =
          plants.plantList.map((e) => Plant.fromJson(e)).toList();
      for (var item in pList) {
        print(item.name);
      }
      return pList;
    } else {
      print("statusCode=${res.statusCode}");
      List<Plant> empty = [];
      return empty;
    }
  }
}
