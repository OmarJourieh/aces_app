import 'dart:convert';

import 'package:aces_app/models/disease.dart';
import 'package:flutter/material.dart';
import 'package:aces_app/constants/constants.dart';

import 'package:http/http.dart' as http;

class DiseasesProvider {
  Future<List<Disease>> getDiseasesOfPlant(int plantId) async {
    var res = await http.get(
      Uri.parse('$baseAPI/getDiseasesOfPlant/' + plantId.toString()),
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      },
    );
    if (res.statusCode == 200) {
      String data = res.body;
      var jsonData = jsonDecode(data);
      Diseases diseases = Diseases.fromjson(jsonData);
      List<Disease> pList =
          diseases.diseaseList.map((e) => Disease.fromJson(e)).toList();
      for (var item in pList) {
        print(item.name);
      }
      return pList;
    } else {
      print("statusCode=${res.statusCode}");
      List<Disease> empty = [];
      return empty;
    }
  }
}
