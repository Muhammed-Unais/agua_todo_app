import 'package:agua_todo_app/data/response/local_sevice_response.dart';
import 'package:agua_todo_app/features/add_task_view/view/add_tasks.dart';
import 'package:agua_todo_app/features/home/model/task_model.dart';
import 'package:agua_todo_app/features/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Management'),
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
          // Rebuild whenever tasks change

          final categories = value.$2.keys.toList();

          return SingleChildScrollView(
            child: ExpansionPanelList.radio(
              children: categories.map((category) {
                return ExpansionPanelRadio(
                  value: category,
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title:
                          Text(category, style: const TextStyle(fontSize: 18)),
                    );
                  },
                  body: Column(
                    children: value.$2[category]!.asMap().entries.map((entry) {
                      final task = entry.value;
                      final absoluteIndex = value.$1.data?.indexOf(task);

                      return Dismissible(
                        onDismissed: (direction) {},
                        key: ValueKey(entry),
                        background: Container(color: Colors.red),
                        secondaryBackground: Container(color: Colors.green),
                        direction: DismissDirection.horizontal,
                        confirmDismiss: (direction) async {
                          final homeViewModel = context.read<HomeViewModel>();
                          if (direction == DismissDirection.endToStart) {
                            await homeViewModel.updateTaskCompletion(
                                absoluteIndex ?? 0, true, task);
                            return false;
                          } else if (direction == DismissDirection.startToEnd) {
                            homeViewModel.deleteTask(absoluteIndex ?? 0);
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
                              ? const Icon(Icons.check, color: Colors.green)
                              : const Icon(Icons.pending, color: Colors.grey),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
