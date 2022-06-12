// To parse this JSON data, do
//
//     final weather = weatherFromJson(jsonString);

import 'dart:convert';

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

String weatherToJson(Weather data) => json.encode(data.toJson());

class Weather {
  Weather({
    this.temp,
    this.humidity,
    this.pressure,
    this.wind,
    this.city,
    this.description,
    this.icon,
  });

  double? temp;
  int? humidity;
  int? pressure;
  double? wind;
  String? city;
  String? description;
  String? icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        temp: json["temp"],
        humidity: json["humidity"],
        pressure: json["pressure"],
        wind: json["wind"].toDouble(),
        city: json["city"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "humidity": humidity,
        "pressure": pressure,
        "wind": wind,
        "city": city,
        "description": description,
        "icon": icon,
      };
}
