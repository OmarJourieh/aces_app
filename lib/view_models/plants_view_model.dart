import 'package:aces_app/models/api_statues.dart';
import 'package:aces_app/models/plant.dart';
import 'package:aces_app/models/task_error.dart';
import 'package:aces_app/models/weather.dart';
import 'package:aces_app/providers/plants_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlantsViewModel extends ChangeNotifier {
  bool _loading = false;
  List<Plant> _plantListModel = [];
  UserError? _plantError;
  Plant? _selectedPlant;
  Weather? _weather;
  String? _timeNow;

  Weather? get weather => _weather;
  bool get loading => _loading;
  List<Plant> get plantListModel => _plantListModel;
  UserError? get plantError => _plantError;
  Plant? get selectedplant => _selectedPlant;
  String? get timeNow => _timeNow;
  PlantsViewModel() {
    getAllPlants();
    setTime();
    getWeather();
  }

  setTime() {
    _timeNow = DateFormat.yMMMMd('en_US').format(DateTime.now());
  }

  setSelectedPlant(Plant plantModel) {
    _selectedPlant = plantModel;
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setPlantListModel(List<Plant> plantListModel) {
    _plantListModel = plantListModel;
  }

  setWeatherModel(Weather WeatherMode) {
    _weather = WeatherMode;
  }

  setPlantError(UserError plantError) {
    _plantError = plantError;
  }

  getAllPlants() async {
    setLoading(true);
    var response = await PlantsProvider.getAllPlants();
    if (response is Success) {
      setPlantListModel(response.response as List<Plant>);
    }
    if (response is Failure) {
      UserError userError = UserError(
        code: response.code,
        message: response.errorResponse.toString(),
      );
      setPlantError(userError);
    }
    setLoading(false);
  }

  getWeather() async {
    setLoading(true);
    var response = await PlantsProvider.getWeather('1');
    if (response is Success) {
      setWeatherModel(response.response as Weather);
    }
    if (response is Failure) {
      UserError userError = UserError(
        code: response.code,
        message: response.errorResponse.toString(),
      );
      setPlantError(userError);
    }
    setLoading(false);
  }
}
