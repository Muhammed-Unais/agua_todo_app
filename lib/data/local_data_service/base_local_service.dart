import 'package:agua_todo_app/features/home/model/task_model.dart';

abstract interface class BaseLocalDataService {
  Future<dynamic> getData();
  Future<void> postData(TaskModel taskModel);
  Future<void> putData(int index, TaskModel taskModel);
  Future<void> deleteData(int index);
  dynamic getAt(int index);
}
