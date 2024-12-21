import 'package:agua_todo_app/data/local_data_service/base_local_service.dart';
import 'package:agua_todo_app/features/home/model/task_model.dart';

class AddTaskLocalRepository {
  final BaseLocalDataService baseLocalDataService;

  AddTaskLocalRepository(this.baseLocalDataService);

  Future<void> postTask(TaskModel taskModel) async {
    try {
      baseLocalDataService.postData(taskModel);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editTask(int index, TaskModel taskModel) async {
    try {
      baseLocalDataService.putData(index, taskModel);
    } catch (e) {
      rethrow;
    }
  }
}
