import 'package:agua_todo_app/data/local_data_service/base_local_service.dart';
import 'package:agua_todo_app/features/home/model/task_model.dart';

class GetTasksRepository {
  final BaseLocalDataService baseLocalDataService;

  GetTasksRepository({required this.baseLocalDataService});

  Future<List<TaskModel>> getAllTaskRepository() async {
    return await baseLocalDataService.getData();
  }
}
