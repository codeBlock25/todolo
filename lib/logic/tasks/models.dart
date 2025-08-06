part of 'tasks.dart';

enum Priority {
  low(value: 'low'),
  medium(value: 'medium'),
  high(value: 'high');

  final String value;

  const Priority({required this.value});

  factory Priority.fromValue(String value) {
    switch (value) {
      case 'low':
        return Priority.low;
      case 'medium':
        return Priority.medium;
      case 'high':
        return Priority.high;
      default:
        throw ArgumentError('Invalid priority value: $value');
    }
  }

  String toValue() => value;
}

class Task {
  String id;
  String title;
  String content;
  String projectId;
  DateTime createdAt;
  DateTime lastUpdated;
  Priority priority;
  DateTime dueDate;
  String status;

  Task({
    required this.id,
    required this.title,
    required this.content,
    required this.projectId,
    required this.createdAt,
    required this.lastUpdated,
    required this.priority,
    required this.dueDate,
    required this.status,
  });

  Task copyWith({
    String? id,
    String? title,
    String? content,
    String? projectId,
    DateTime? createdAt,
    DateTime? lastUpdated,
    Priority? priority,
    DateTime? dueDate,
    String? status,
  }) => Task(
    id: id ?? this.id,
    title: title ?? this.title,
    content: content ?? this.content,
    projectId: projectId ?? this.projectId,
    createdAt: createdAt ?? this.createdAt,
    lastUpdated: lastUpdated ?? this.lastUpdated,
    priority: priority ?? this.priority,
    dueDate: dueDate ?? this.dueDate,
    status: status ?? this.status,
  );

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    projectId: json["projectId"],
    createdAt: DateTime.parse(json["createdAt"]),
    lastUpdated: DateTime.parse(json["lastUpdated"]),
    priority: Priority.fromValue(json["priority"]),
    dueDate: DateTime.parse(json["dueDate"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "projectId": projectId,
    "createdAt":
        "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    "lastUpdated":
        "${lastUpdated.year.toString().padLeft(4, '0')}-${lastUpdated.month.toString().padLeft(2, '0')}-${lastUpdated.day.toString().padLeft(2, '0')}",
    "priority": priority.toValue(),
    "dueDate":
        "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
    "status": status,
  };
}
