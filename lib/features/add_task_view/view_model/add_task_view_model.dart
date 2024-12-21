import 'package:agua_todo_app/features/add_task_view/repository/add_task_local_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agua_todo_app/data/local_data_service/local_data_service.dart';
import 'package:agua_todo_app/features/home/model/task_model.dart';
import 'package:agua_todo_app/features/home/view_model/home_view_model.dart';

class AddTaskViewModel with ChangeNotifier {
  final _addTaskRepo = AddTaskLocalRepository(LocalDataService());
  TextEditingController taskTextEditingController = TextEditingController();
  bool postIsLoading = false;

  void setPostTasks(bool isLoading) {
    postIsLoading = isLoading;
    notifyListeners();
  }

  Future<void> postTask({
    required String title,
    required String description,
    required String category,
    required bool status,
    required BuildContext context,
  }) async {
    setPostTasks(true);
    final taskModel = TaskModel(
      title: title,
      description: description,
      category: category,
      status: status,
    );
    _addTaskRepo.postTask(taskModel).then((value) {
      if (!context.mounted) return;
      context.read<HomeViewModel>().getAllTask();
      setPostTasks(false);
      taskTextEditingController.clear();
    }).onError(
      (error, stackTrace) {
        setPostTasks(false);
      },
    );
  }

  Future<void> editTask(
    int index,
    TaskModel taskModel,
    BuildContext context, {
    String? title,
    String? description,
    String? category,
    bool? status,
  }) async {
    final newTaskModel = taskModel.copyWith(
      category: category,
      title: title,
      description: description,
      status: status,
    );
    _addTaskRepo.editTask(index, newTaskModel).then((value) {
      if (!context.mounted) return;

      context.read<HomeViewModel>().getAllTask();

      taskTextEditingController.clear();
    }).onError(
      (error, stackTrace) {},
    );
  }
}
