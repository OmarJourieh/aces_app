// import 'dart:convert';

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? email;
  String? password;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Users {
  final List<dynamic> userList;

  Users({required this.userList});

  factory Users.fromjson(List<dynamic> jsonData) {
    return Users(
      userList: jsonData,
    );
  }
}
