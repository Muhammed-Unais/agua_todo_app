import 'package:agua_todo_app/data/local_data_service/base_local_service.dart';

class DeleteRepo {
  final BaseLocalDataService baseLocalDataService;

  DeleteRepo({required this.baseLocalDataService});

  Future<void> deleteTask(int index) async {
    try {
      baseLocalDataService.deleteData(index);
    } catch (e) {
      rethrow;
    }
  }
}
