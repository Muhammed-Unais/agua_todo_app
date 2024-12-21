import 'package:agua_todo_app/features/search/view_model/search_viewmode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchViewmodel>(context);
    final filtered =
        searchProvider.filteredTasks(searchProvider.searchQuery, context);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(
            hintText: 'Search tasks...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white60),
          ),
          style: const TextStyle(color: Colors.black),
          onChanged: (val) {
            searchProvider.setSearchQuery(val);
          },
        ),
      ),
      body: filtered.isEmpty
          ? const Center(
              child: Text("No search result"),
            )
          : ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final task = filtered[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  trailing: task.status
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : const Icon(Icons.circle_outlined, color: Colors.grey),
                );
              },
            ),
    );
  }
}
