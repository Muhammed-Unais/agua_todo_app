import 'package:agua_todo_app/features/add_task_view/view/components/category_dropdown.dart';
import 'package:agua_todo_app/features/add_task_view/view_model/add_task_view_model.dart';
import 'package:agua_todo_app/features/add_task_view/view_model/drop_down_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            const CategoryDropdown(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final addTaskViewModel = context.read<AddTaskViewModel>();
                  final categoryViewModel = context.read<CategoryViewModel>();

                  final title = _titleController.text.trim();
                  final description = _descriptionController.text.trim();
                  final category = categoryViewModel.selectedCategory;

                  addTaskViewModel.postTask(
                    title: title,
                    description: description,
                    category: category,
                    status: false,
                    context: context,
                  );
                }
              },
              child: const Text('Add Task'),
            )
          ],
        ),
      ),
    );
  }
}
