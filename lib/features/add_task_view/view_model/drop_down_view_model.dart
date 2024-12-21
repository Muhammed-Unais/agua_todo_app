import 'package:flutter/material.dart';

class CategoryViewModel with ChangeNotifier {
  final List<String> _categories = ["Work", "Personal", "Others"];

  String _selectedCategory = "Work";

  List<String> get categories => _categories;

  String get selectedCategory => _selectedCategory;

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners(); // Notifies the UI to rebuild
  }
}
