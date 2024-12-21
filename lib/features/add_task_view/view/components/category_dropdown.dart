import 'package:agua_todo_app/features/add_task_view/view_model/drop_down_view_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryDropdown extends StatelessWidget {
  const CategoryDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Category",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField2<String>(
          isExpanded: true,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          buttonStyleData: const ButtonStyleData(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 8),
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
          ),
          hint: const Text(
            'Choose a category...',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          items: categoryProvider.categories
              .map((cat) => DropdownMenuItem<String>(
                    value: cat,
                    child: Text(
                      cat,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ))
              .toList(),
          value: categoryProvider.selectedCategory,
          onChanged: (String? newValue) {
            if (newValue != null) {
              categoryProvider.setSelectedCategory(newValue);
            }
          },
        ),
      ],
    );
  }
}
