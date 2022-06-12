import 'package:aces_app/models/api_statues.dart';
import 'package:aces_app/models/task.dart';
import 'package:aces_app/models/task_error.dart';
import 'package:aces_app/providers/task_provider.dart';
import 'package:flutter/material.dart';

class TasksViewModel extends ChangeNotifier {
  bool _loading = false;
  List<Task> _taskListModel = [];
  UserError? _userError;
  Task? _selectedTask;

  bool get loading => _loading;
  List<Task> get taskListModel => _taskListModel;
  UserError? get userError => _userError;
  Task? get selectedTask => _selectedTask;

  TasksViewModel() {
    getTasks();
  }
  setSelectedTask(Task taskModel) {
    _selectedTask = taskModel;
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setUserListModel(List<Task> taskListModel) {
    _taskListModel = taskListModel;
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  getTasks() async {
    setLoading(true);
    var response = await TasksProvider.getAllTasks('1');
    if (response is Success) {
      setUserListModel(response.response as List<Task>);
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
