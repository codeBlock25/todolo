part of 'projects.dart';

class ProjectModel {
  String id;
  String name;
  String? description;
  DateTime createdAt;
  DateTime lastOpened;
  List<String> tasks;

  ProjectModel({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
    required this.lastOpened,
    required this.tasks,
  });

  ProjectModel copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? createdAt,
    DateTime? lastOpened,
    List<String>? tasks,
  }) => ProjectModel(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    createdAt: createdAt ?? this.createdAt,
    lastOpened: lastOpened ?? this.lastOpened,
    tasks: tasks ?? this.tasks,
  );

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    createdAt: DateTime.parse(json["createdAt"]),
    lastOpened: DateTime.parse(json["lastOpened"]),
    tasks: List<String>.from(json["tasks"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "createdAt":
        "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    "lastOpened":
        "${lastOpened.year.toString().padLeft(4, '0')}-${lastOpened.month.toString().padLeft(2, '0')}-${lastOpened.day.toString().padLeft(2, '0')}",
    "tasks": tasks,
  };
}
