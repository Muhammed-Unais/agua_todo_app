import 'package:flutter/material.dart';
import 'package:agua_todo_app/data/local_data_service/local_data_service.dart';
import 'package:agua_todo_app/data/response/local_sevice_response.dart';
import 'package:agua_todo_app/features/home/model/task_model.dart';
import 'package:agua_todo_app/features/home/repository/delete_repo.dart';
import 'package:agua_todo_app/features/home/repository/get_tasks_repository.dart';
import 'package:agua_todo_app/features/home/repository/task_complete_repository.dart';

class HomeViewModel with ChangeNotifier {
  final _myGetAllTaskRepo =
      GetTasksRepository(baseLocalDataService: LocalDataService());
  final _myDeleteTaskRepo =
      DeleteRepo(baseLocalDataService: LocalDataService());
  final _myTaskCompletionRepo = TaskCompleteRepository(LocalDataService());
  LocalServiceResponse<List<TaskModel>> getAllTaskResponse =
      LocalServiceResponse.loading();
  bool postIsLoading = false;
  bool deleteIsLoading = false;

  void setDeleteTasks(bool isLoading) {
    deleteIsLoading = isLoading;
    notifyListeners();
  }

  void setPostTasks(bool isLoading) {
    postIsLoading = isLoading;
    notifyListeners();
  }

  void setGetAllTasks(
      LocalServiceResponse<List<TaskModel>> localServiceResponse) {
    getAllTaskResponse = localServiceResponse;
    notifyListeners();
  }

  void getAllTask() async {
    setGetAllTasks(LocalServiceResponse.loading());

    await _myGetAllTaskRepo.getAllTaskRepository().then((value) {
      setGetAllTasks(LocalServiceResponse.completed(value));
    }).onError(
      (error, stackTrace) {
        setGetAllTasks(LocalServiceResponse.error(error.toString()));
      },
    );
  }

  void deleteTask(int index) async {
    setDeleteTasks(true);
    await _myDeleteTaskRepo.deleteTask(index).then((value) {
      getAllTask();
      setDeleteTasks(false);
    }).onError(
      (error, stackTrace) {
        setDeleteTasks(false);
      },
    );
  }

  Future<void> updateTaskCompletion(
    int index,
    bool status,
    TaskModel taskModel,
  ) async {
    var newtaskModel = taskModel.copyWith(status: status);

    await _myTaskCompletionRepo
        .updateTaskCompletion(index, newtaskModel)
        .then((value) {
      getAllTask();
    }).onError((error, stackTrace) {});
  }

  Map<String, List<TaskModel>> get tasksByCategory {
    final Map<String, List<TaskModel>> grouped = {};

    final tasks = getAllTaskResponse.data ?? [];

    for (var task in tasks) {
      final cat = task.category;
      if (!grouped.containsKey(cat)) {
        grouped[cat] = [];
      }
      grouped[cat]!.add(task);
    }
    return grouped;
  }

  HomeViewModel() {
    getAllTask();
  }
}
