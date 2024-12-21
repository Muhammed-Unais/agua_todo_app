import 'package:agua_todo_app/features/add_task_view/repository/add_task_local_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agua_todo_app/data/local_data_service/local_data_service.dart';
import 'package:agua_todo_app/features/home/model/task_model.dart';
import 'package:agua_todo_app/features/home/view_model/home_view_model.dart';

class AddTaskViewModel with ChangeNotifier {
  final _addTaskRepo = AddTaskLocalRepository(LocalDataService());
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
    final homeViewmodel = context.read<HomeViewModel>();

    setPostTasks(true);
    final taskModel = TaskModel(
      title: title,
      description: description,
      category: category,
      status: status,
    );

    if (homeViewmodel.isDuplicate(taskModel)) {
      // TODO show a snackBar

      return;
    }
    _addTaskRepo.postTask(taskModel).then((value) {
      if (!context.mounted) return;
      context.read<HomeViewModel>().getAllTask();
      setPostTasks(false);

      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
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
    final homeViewmodel = context.read<HomeViewModel>();

    final newTaskModel = taskModel.copyWith(
      category: category,
      title: title,
      description: description,
      status: status,
    );

    if (homeViewmodel.isDuplicate(newTaskModel)) {
      // TODO show a snackBar
      return;
    }
    _addTaskRepo.editTask(index, newTaskModel).then((value) {
      if (!context.mounted) return;

      homeViewmodel.getAllTask();
    }).onError(
      (error, stackTrace) {},
    );
  }
}
