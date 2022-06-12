import 'dart:convert';
import 'package:aces_app/constants/constants.dart';
import 'package:aces_app/models/api_statues.dart';
import 'package:aces_app/models/stage.dart';
import 'package:http/http.dart' as http;

import 'dart:io';

class StageProvider {
  static Future<Object> getallStageWithStep(String id) async {
    try {
      var response = await http.get(
        Uri.parse('$baseAPI/getallStageWithStep/' + id),
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
      );

      if (SUCCESS == response.statusCode) {
        var xx = jsonDecode(response.body);

        if (xx['status'] == true) {
          var resuilt = stageFromJson(jsonEncode(xx['Stages']));
          print(resuilt);
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
