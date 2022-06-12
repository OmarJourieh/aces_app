import 'package:aces_app/models/api_statues.dart';
import 'package:aces_app/models/step.dart';
import 'package:aces_app/models/task_error.dart';
import 'package:aces_app/providers/step.dart';
import 'package:flutter/material.dart';

class StpsViewModel extends ChangeNotifier {
  bool _loading = false;
  List<Stepe> _stepListModel = [];
  UserError? _stepError;
  Stepe? _selectedtask;

  bool get loading => _loading;
  List<Stepe> get stepListModel => _stepListModel;
  UserError? get stepError => _stepError;
  Stepe? get selectedtask => _selectedtask;

  setSelectedTask(Stepe stepModel) {
    _selectedtask = stepModel;
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setStepListModel(List<Stepe> stepListModel) {
    _stepListModel = stepListModel;
  }

  setUserError(UserError stepError) {
    _stepError = stepError;
  }

  getStps(String stepId) async {
    setLoading(true);
    var response = await StepsProvider.getScheduleWork(stepId);
    if (response is Success) {
      setStepListModel(response.response as List<Stepe>);
    }
    if (response is Failure) {
      UserError userError = UserError(
        code: response.code,
        message: response.errorResponse.toString(),
      );
      setUserError(userError);
    }
    setLoading(false);
  }
}
