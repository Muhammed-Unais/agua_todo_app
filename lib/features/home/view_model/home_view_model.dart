import 'package:agua_todo_app/features/home/repository/task_manupulate_local_repository.dart';
import 'package:flutter/material.dart';
import 'package:agua_todo_app/data/local_data_service/local_data_service.dart';
import 'package:agua_todo_app/data/response/local_sevice_response.dart';
import 'package:agua_todo_app/features/home/model/task_model.dart';

class HomeViewModel with ChangeNotifier {
  final _taskManupulationRepo =
      TaskManupulateLocalRepository(baseLocalDataService: LocalDataService());
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

    await _taskManupulationRepo.getAllTaskRepository().then((value) {
      setGetAllTasks(LocalServiceResponse.completed(value));
    }).onError(
      (error, stackTrace) {
        setGetAllTasks(LocalServiceResponse.error(error.toString()));
      },
    );
  }

  void deleteTask(int index) async {
    setDeleteTasks(true);
    await _taskManupulationRepo.deleteTask(index).then((value) {
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

    await _taskManupulationRepo
        .updateTaskCompletion(index, newtaskModel)
        .then((value) {
      var tasks = getAllTaskResponse.data ?? [];

      tasks.removeAt(index);
      tasks.add(newtaskModel);

      setGetAllTasks(LocalServiceResponse.completed(tasks));
    }).onError((error, stackTrace) {});
  }

  bool isDuplicate(TaskModel task) {
    final tasks = getAllTaskResponse.data ?? [];
    return tasks.any((element) => element == task);
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

  int get totalTasksCount => getAllTaskResponse.data?.length ?? 0;

  int get completedTasksCount =>
      getAllTaskResponse.data?.where((task) => task.status).length ?? 0;

  double get progress {
    if (totalTasksCount == 0) return 0.0;
    return completedTasksCount / totalTasksCount;
  }

  HomeViewModel() {
    getAllTask();
  }
}
