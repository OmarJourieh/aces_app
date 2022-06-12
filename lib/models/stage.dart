// To parse this JSON data, do
//
//     final stage = stageFromJson(jsonString);

import 'dart:convert';

import 'package:aces_app/models/step.dart';

List<Stage> stageFromJson(String str) =>
    List<Stage>.from(json.decode(str).map((x) => Stage.fromJson(x)));

String stageToJson(List<Stage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Stage {
  Stage({
    this.id,
    this.plantId,
    this.name,
    this.interval,
    this.description,
    this.step,
    this.week,
    this.wateringPeriod,
    this.createdAt,
    this.updatedAt,
    this.steps,
  });

  int? id;
  int? plantId;
  String? name;
  int? interval;
  dynamic? description;
  int? step;
  int? week;
  dynamic? wateringPeriod;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Stepe>? steps;

  factory Stage.fromJson(Map<String, dynamic> json) => Stage(
        id: json["id"],
        plantId: json["plant_id"],
        name: json["name"],
        interval: json["interval"],
        description: json["description"],
        step: json["step"],
        week: json["week"],
        wateringPeriod: json["watering_period"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        steps: List<Stepe>.from(json["steps"].map((x) => Stepe.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "plant_id": plantId,
        "name": name,
        "interval": interval,
        "description": description,
        "step": step,
        "week": week,
        "watering_period": wateringPeriod,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "steps": List<dynamic>.from(steps!.map((x) => x.toJson())),
      };
}
