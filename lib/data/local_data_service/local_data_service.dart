import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:agua_todo_app/data/local_data_service/base_local_service.dart';
import 'package:agua_todo_app/features/home/model/task_model.dart';

class LocalDataService implements BaseLocalDataService {
  final taskBox = Hive.box<TaskModel>('task-model');
  @override
  Future<dynamic> getData() async {
    return taskBox.values.toList();
  }

  @override
  Future<void> postData(TaskModel taskModel) async {
    try {
      await taskBox.add(taskModel);
    } catch (e) {
      log(e.toString());

      throw e.toString();
    }
  }

  @override
  Future<void> putData(int index, TaskModel taskModel) async {
    try {
      taskBox.putAt(index, taskModel);
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> deleteData(int index) async {
    try {
      taskBox.deleteAt(index);
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  TaskModel? getAt(int index) {
    return taskBox.getAt(index);
  }
}
