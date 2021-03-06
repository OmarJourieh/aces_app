class Plant {
  int? id;
  String? name;
  String? description;
  String? image;
  String? season;
  String? createdAt;
  String? updatedAt;

  Plant(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.season,
      this.createdAt,
      this.updatedAt});

  Plant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    season = json['season'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['season'] = this.season;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Plants {
  final List<dynamic> plantList;

  Plants({required this.plantList});

  factory Plants.fromjson(dynamic jsonData) {
    return Plants(
      plantList: jsonData['plants'],
    );
  }
}
