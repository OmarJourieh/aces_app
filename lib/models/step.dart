// To parse this JSON data, do
//
//     final stepe = stepeFromJson(jsonString);

import 'dart:convert';

List<Stepe> stepeFromJson(String str) =>
    List<Stepe>.from(jsonDecode(str).map((x) => Stepe.fromJson(x)));

String stepeToJson(List<Stepe> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Stepe {
  Stepe({
    this.id,
    this.plantScheduleId,
    this.stageId,
    this.interval,
    this.isRepeating,
    this.description,
    this.title,
    this.stageName,
    this.duration,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.step,
  });

  int? id;
  int? plantScheduleId;
  int? stageId;
  int? interval;
  int? step;
  int? duration;
  dynamic? isRepeating;
  String? description;
  String? title;
  String? stageName;
  dynamic? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Stepe.fromJson(Map<String, dynamic> json) => Stepe(
        id: json["id"],
        plantScheduleId: json["plant_schedule_id"],
        stageId: json["stage_id"],
        interval: json["interval"],
        duration: json["duration"],
        isRepeating: json["is_repeating"],
        description: json["description"],
        title: json["title"],
        stageName: json["stageName"],
        image: json["image"],
        step: json["step"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "plant_schedule_id": plantScheduleId,
        "stage_id": stageId,
        "interval": interval,
        "duration": duration,
        "is_repeating": isRepeating,
        "description": description,
        "title": title,
        "stageName": stageName,
        "image": image,
        "step": step,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
