// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:agua_todo_app/features/add_task_view/view/add_tasks.dart';
// import 'package:agua_todo_app/features/add_task_view/view_model/add_task_view_model.dart';
// import 'package:agua_todo_app/features/home/model/task_model.dart';
// import 'package:agua_todo_app/features/home/view_model/home_view_model.dart';

// class TodoListTile extends StatelessWidget {
//   const TodoListTile({
//     super.key,
//     required this.task,
//     required this.index,
//   });

//   final TaskModel task;
//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       child: ListTile(
//         leading: CircleAvatar(
//           child: !task.status
//               ? Checkbox(
//                   value: false,
//                   onChanged: (value) {
//                     var homeProvider = context.read<HomeViewModel>();
//                     homeProvider.updateTaskCompletion(
//                       index,
//                       value ?? false,
//                       task,
//                     );
//                   },
//                 )
//               : const Icon(
//                   Icons.done,
//                   color: Colors.green,
//                 ),
//         ),
//         title: Text(task.task),
//         trailing: PopupMenuButton(
//           onSelected: (value) {
//             var homeProvider = context.read<HomeViewModel>();

//             if (value == "Delete") {
//               homeProvider.deleteTask(index);
//             } else if (value == "Edit") {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) {
//                     return AddTasks(
//                       taskModel: task,
//                       isCreate: false,
//                       index: index,
//                     );
//                   },
//                 ),
//               );

//               var addTaskProvider = context.read<AddTaskViewModel>();
//               addTaskProvider.taskTextEditingController.text = task.task;
//             }
//           },
//           itemBuilder: (context) {
//             return [
//               const PopupMenuItem(
//                 value: "Delete",
//                 child: Text(
//                   "Delete",
//                 ),
//               ),
//               const PopupMenuItem(
//                 value: "Edit",
//                 child: Text(
//                   "Edit",
//                 ),
//               ),
//             ];
//           },
//         ),
//       ),
//     );
//   }
// }
