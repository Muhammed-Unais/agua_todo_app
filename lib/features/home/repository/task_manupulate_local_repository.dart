import 'package:agua_todo_app/data/local_data_service/base_local_service.dart';
import 'package:agua_todo_app/features/home/model/task_model.dart';

class TaskManupulateLocalRepository {
  final BaseLocalDataService baseLocalDataService;

  TaskManupulateLocalRepository({required this.baseLocalDataService});

  Future<List<TaskModel>> getAllTaskRepository() async {
    return await baseLocalDataService.getData();
  }

  Future<void> postTask(TaskModel taskModel) async {
    try {
      baseLocalDataService.postData(taskModel);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTask(int index) async {
    try {
      baseLocalDataService.deleteData(index);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTaskCompletion(int index, TaskModel taskModel) async {
    try {
      baseLocalDataService.putData(index, taskModel);
    } catch (e) {
      rethrow;
    }
  }
}
