import 'package:cloud_firestore/cloud_firestore.dart';

class Skill {
  String id;
  String skillName;
  String category;
  String difficulty;

  int progress;

  List<String> resources;
  List<bool> resourcesCompleted;

  String description;

  DateTime createdDate;
  DateTime lastUpdated;

  bool completed;

  Skill({
    this.id = "",

    required this.skillName,
    required this.category,
    required this.difficulty,

    required this.progress,

    required this.resources,
    required this.resourcesCompleted,

    required this.description,

    required this.createdDate,
    required this.lastUpdated,

    required this.completed,
  });

  Map<String, dynamic> toMap() {
    return {
      "skillName": skillName,
      "category": category,
      "difficulty": difficulty,

      "progress": progress,

      "resources": resources,
      "resourcesCompleted": resourcesCompleted,

      "description": description,

      "createdDate": Timestamp.fromDate(createdDate),
      "lastUpdated": Timestamp.fromDate(lastUpdated),

      "completed": completed,
    };
  }

  factory Skill.fromMap(
      String id,
      Map<String, dynamic> map,
      ) {
    return Skill(
      id: id,

      skillName: map["skillName"] ?? "",

      category: map["category"] ?? "",

      difficulty: map["difficulty"] ?? "",

      progress: map["progress"] ?? 0,

      resources:
      List<String>.from(map["resources"] ?? []),

      resourcesCompleted:
      List<bool>.from(map["resourcesCompleted"] ?? []),

      description: map["description"] ?? "",

      createdDate:
      (map["createdDate"] as Timestamp).toDate(),

      lastUpdated:
      (map["lastUpdated"] as Timestamp).toDate(),

      completed: map["completed"] ?? false,
    );
  }
}