import 'package:aces_app/models/api_statues.dart';
import 'package:aces_app/models/stage.dart';
import 'package:aces_app/models/step.dart';
import 'package:aces_app/models/task_error.dart';
import 'package:aces_app/providers/stage.dart';
import 'package:flutter/material.dart';

class StagesViewModel extends ChangeNotifier {
  bool _loading = false;
  List<Stage> _stageListModel = [];
  List<Stepe> _listStep = [];
  UserError? _stageError;
  Stage? _selectedstage;
  Stepe? sstep;

  bool get loading => _loading;
  List<Stage> get stageListModel => _stageListModel;
  List<Stepe> get listStep => _listStep;
  UserError? get stageError => _stageError;
  Stage? get selectedstage => _selectedstage;

  StagesViewModel() {
    getStage();
  }

  setSelectedStage(Stage stageModel) {
    _selectedstage = stageModel;
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setStepListModel(List<Stage> stageListModel) {
    _stageListModel = stageListModel;
  }

  setUserError(UserError stageError) {
    _stageError = stageError;
  }

  getStage() async {
    setLoading(true);
    var response = await StageProvider.getallStageWithStep('1');
    if (response is Success) {
      setStepListModel(response.response as List<Stage>);
    }
    if (response is Failure) {
      UserError stageError = UserError(
        code: response.code,
        message: response.errorResponse.toString(),
      );
      setUserError(stageError);
    }
    setLoading(false);
  }
}
