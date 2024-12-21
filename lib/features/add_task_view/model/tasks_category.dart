// import 'package:flutter/foundation.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:agua_todo_app/features/home/model/task_model.dart';
// part 'tasks_category.g.dart';

// @HiveType(typeId: 2)
// class TasksCategory {
//   @HiveField(1)
//   List<TaskModel> tasks;

//   TasksCategory({
//     required this.tasks,
//   });

//   void add(TaskModel taskModel) {
//     tasks.add(taskModel);
//   }

//   void delete(TaskModel taskModel) {
//     tasks.remove(taskModel);
//   }
  

//   TasksCategory copyWith({
//     List<TaskModel>? tasks,
//   }) {
//     return TasksCategory(
//       tasks: tasks ?? this.tasks,
//     );
//   }

//   @override
//   String toString() => 'TasksCategory(tasks: $tasks)';

//   @override
//   bool operator ==(covariant TasksCategory other) {
//     if (identical(this, other)) return true;

//     return listEquals(other.tasks, tasks);
//   }

//   @override
//   int get hashCode => tasks.hashCode;
// }
