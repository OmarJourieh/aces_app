class Disease {
  int? id;
  String? name;
  int? plantId;
  String? description;
  String? symptoms;
  String? cure;
  String? createdAt;
  String? updatedAt;

  Disease(
      {this.id,
      this.name,
      this.plantId,
      this.description,
      this.symptoms,
      this.cure,
      this.createdAt,
      this.updatedAt});

  Disease.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    plantId = json['plant_id'];
    description = json['description'];
    symptoms = json['symptoms'];
    cure = json['cure'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['plant_id'] = this.plantId;
    data['description'] = this.description;
    data['symptoms'] = this.symptoms;
    data['cure'] = this.cure;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Diseases {
  final List<dynamic> diseaseList;

  Diseases({required this.diseaseList});

  factory Diseases.fromjson(List<dynamic> jsonData) {
    return Diseases(
      diseaseList: jsonData,
    );
  }
}
