import 'package:agua_todo_app/data/local_data_service/base_local_service.dart';
import 'package:agua_todo_app/features/home/model/task_model.dart';

class TaskCompleteRepository {
  final BaseLocalDataService baseLocalDataService;

  TaskCompleteRepository(this.baseLocalDataService);

  Future<void> updateTaskCompletion(int index, TaskModel taskModel) async {
    try {
      baseLocalDataService.putData(index, taskModel);
    } catch (e) {
      rethrow;
    }
  }
}
