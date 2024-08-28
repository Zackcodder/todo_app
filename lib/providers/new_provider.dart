import 'package:flutter/material.dart';
import 'package:todo_app/models/new_model.dart';
import 'package:todo_app/services/task_services.dart';

class NewTaskProvider with ChangeNotifier {
   final TaskServices _taskService = TaskServices();
  NewTaskModel? _lastDeletedTask;
  int? _lastDeletedTaskIndex;


  final List<NewTaskModel> _tasks = [];

  List<NewTaskModel> get tasks => _tasks;

  void addTask(String title) {
    _tasks.add(NewTaskModel(title: title));
    notifyListeners();
  }

  void deleteTask(int index) async{
    final deleteState = await _taskService.deleteTask(index);
    if (deleteState) {
      print('delete state: $deleteState');
    _lastDeletedTask = _tasks[index];
    _lastDeletedTaskIndex = index;
    _tasks.removeAt(index);
      notifyListeners();
    } else {
      print('delete state error: $deleteState');
    }
    notifyListeners();
  }
undoDelete() {
    if (_lastDeletedTask != null && _lastDeletedTaskIndex != null) {
      _tasks.insert(_lastDeletedTaskIndex!, _lastDeletedTask!);
      _lastDeletedTask = null;
      _lastDeletedTaskIndex = null;
      notifyListeners();
    }
  }
  void toggleTaskCompletion(int index) async{
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    notifyListeners();
  }

  editTask(int index, String newTitle) {
    _tasks[index].title = newTitle;
    notifyListeners();
  }
}
