import 'package:agua_todo_app/core/theme/app_theme.dart';
import 'package:agua_todo_app/data/response/enums.dart';
import 'package:agua_todo_app/data/response/local_sevice_response.dart';
import 'package:agua_todo_app/features/add_task_view/view/add_tasks.dart';
import 'package:agua_todo_app/features/add_task_view/view_model/add_task_view_model.dart';
import 'package:agua_todo_app/features/home/model/task_model.dart';
import 'package:agua_todo_app/features/home/view_model/home_view_model.dart';
import 'package:agua_todo_app/features/search/view/search_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final progressValue = context.select<HomeViewModel, (double, int, int)>(
      (value) {
        return (
          value.progress,
          value.completedTasksCount,
          value.totalTasksCount,
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Management'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const SearchPage();
                },
              ));
            },
            icon: const Icon(Icons.search),
          ),
          Selector<ThemeProvider, bool>(
              selector: (p0, p1) => p1.isDarkMode,
              builder: (context, value, _) {
                return IconButton(
                  icon: Icon(value ? Icons.dark_mode : Icons.light_mode),
                  onPressed: () {
                    final themeProvider = context.read<ThemeProvider>();
                    themeProvider.toggleTheme();
                  },
                );
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const AddTaskPage();
            },
          ));
        },
      ),
      body: Selector<
          HomeViewModel,
          (
            LocalServiceResponse<List<TaskModel>>,
            Map<String, List<TaskModel>>
          )>(
        selector: (p0, p1) => (p1.getAllTaskResponse, p1.tasksByCategory),
        builder: (context, value, _) {
          switch (value.$1.status) {
            case Status.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.completed:
              final categories = value.$2.keys.toList();

              if (categories.isEmpty) {
                return const Center(child: Text("No data"));
              }

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: LinearProgressIndicator(
                      value: progressValue.$1,
                      backgroundColor: Colors.grey[300],
                      color: Colors.blue,
                      minHeight: 8,
                    ),
                  ),
                  Text(
                    '${progressValue.$2} of ${progressValue.$3} tasks completed',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: ExpansionPanelList.radio(
                          materialGapSize: 16,
                          children: categories.map((category) {
                            return ExpansionPanelRadio(
                              value: category,
                              headerBuilder: (context, isExpanded) {
                                return ListTile(
                                  title: Text(category,
                                      style: const TextStyle(fontSize: 18)),
                                );
                              },
                              body: Column(
                                children: value.$2[category]!
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  final task = entry.value;
                                  final absoluteIndex =
                                      value.$1.data?.indexOf(task);

                                  return Dismissible(
                                    onDismissed: (direction) {},
                                    key: ValueKey(entry),
                                    background: Container(color: Colors.red),
                                    secondaryBackground:
                                        Container(color: Colors.green),
                                    direction: DismissDirection.horizontal,
                                    confirmDismiss: (direction) async {
                                      final homeViewModel =
                                          context.read<HomeViewModel>();
                                      if (direction ==
                                          DismissDirection.endToStart) {
                                        await homeViewModel
                                            .updateTaskCompletion(
                                                absoluteIndex ?? 0, true, task);
                                        return false;
                                      } else if (direction ==
                                          DismissDirection.startToEnd) {
                                        homeViewModel
                                            .deleteTask(absoluteIndex ?? 0);

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text("Task deleted"),
                                            action: SnackBarAction(
                                              label: "Undo",
                                              onPressed: () {
                                                final addViewModel = context
                                                    .read<HomeViewModel>();

                                                addViewModel.undoDeletedMessage(
                                                    task, absoluteIndex ?? 0);
                                              },
                                            ),
                                          ),
                                        );

                                        return true;
                                      }
                                      return false;
                                    },
                                    child: ListTile(
                                      title: Text(task.title),
                                      subtitle: Text(
                                        task.description,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      trailing: task.status
                                          ? const Icon(Icons.check,
                                              color: Colors.green)
                                          : const Icon(Icons.pending,
                                              color: Colors.grey),
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              );

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
