import 'package:flutter/foundation.dart';
import 'package:todo_app/Models/Task.dart';
import 'dart:collection';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [
    // Task(name: 'Finish TODOEY'),
    // Task(name: 'Watch Marvel\'s movie'),
    // Task(name: 'Brooklyn 99'),
    // Task(name: 'Sleep'),
    // Task(name: 'Beard Trim')
  ];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get tasksCount {
    return _tasks.length;
  }

  void addTask(String newTask) {
    final task = Task(name: newTask);
    _tasks.add(task);
    notifyListeners(); // TODO IMPORTANT
  }

  void updateTask(Task task) {
    task.taskDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
