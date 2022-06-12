// To parse this JSON data, do
//
//     final task = taskFromJson(jsonString);

import 'dart:convert';

List<Task> taskFromJson(String str) =>
    List<Task>.from(jsonDecode(str).map((x) => Task.fromJson(x)));

String taskToJson(List<Task> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Task {
  Task({
    this.id,
    this.plantId,
    this.title,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? plantId;
  String? title;
  dynamic? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        plantId: json["plant_id"],
        title: json["title"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "plant_id": plantId,
        "title": title,
        "image": image,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
