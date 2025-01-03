import 'package:hive_flutter/hive_flutter.dart';
part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel extends HiveObject {
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  String category;
  @HiveField(4)
  bool status;

  TaskModel({
    required this.title,
    required this.description,
    required this.category,
    required this.status,
  });

  TaskModel copyWith({
    String? title,
    String? description,
    String? category,
    bool? status,
  }) {
    return TaskModel(
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'TaskModel(title: $title, description: $description, category: $category, status: $status)';
  }

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        other.category == category &&
        other.status == status;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        category.hashCode ^
        status.hashCode;
  }
}
