import 'dart:convert';
import 'package:aces_app/constants/constants.dart';
import 'package:aces_app/models/api_statues.dart';
import 'package:aces_app/models/plant.dart';
import 'package:aces_app/models/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class PlantsProvider {
  static Future<Object> getAllPlants() async {
    try {
      var response = await http.get(
        Uri.parse('$baseAPI/getAllPlants'),
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
      );

      if (SUCCESS == response.statusCode) {
        var xx = jsonDecode(response.body);

        if (xx['status'] == true) {
          var resuilt = plantFromJson(jsonEncode(xx['plants']));
          return Success(response: resuilt);
        } else {
          return Failure(
              code: int.tryParse(xx['errNum']), errorResponse: xx['msg']);
        }
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknown Error');
    }
  }

  static Future<Object> getWeather(String id) async {
    try {
      var response = await http.get(
        Uri.parse('$baseAPI/currentWeather/$id'),
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
      );

      if (SUCCESS == response.statusCode) {
        var xx = jsonDecode(response.body);

        if (xx['status'] == true) {
          var resuilt = weatherFromJson(jsonEncode(xx['weather']));
          return Success(response: resuilt);
        } else {
          return Failure(
              code: int.tryParse(xx['errNum']), errorResponse: xx['msg']);
        }
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknown Error');
    }
  }
}
