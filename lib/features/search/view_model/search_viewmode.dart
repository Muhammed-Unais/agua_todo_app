import 'package:agua_todo_app/features/home/model/task_model.dart';
import 'package:agua_todo_app/features/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchViewmodel with ChangeNotifier {
  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<TaskModel> filteredTasks(String searchQuery, BuildContext context) {
    final homeViewModel = context.read<HomeViewModel>();

    final tasks = homeViewModel.getAllTaskResponse.data;
    if (searchQuery.isEmpty) return tasks ?? [];
    return tasks
            ?.where((task) =>
                task.title.toLowerCase().contains(searchQuery.toLowerCase()))
            .toList() ??
        [];
  }
}
