import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  int id;
  String name;
  String username;
  String email;

  User(
      {required this.id,
      required this.name,
      required this.username,
      required this.email});

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      name: json["name"],
      username: json["username"],
      email: json["email"]);

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "username": username, "email": email};

  @override
  String toString() {
    return '{id: $id, name: $name, username: $username,email: $email}';
  }
}
