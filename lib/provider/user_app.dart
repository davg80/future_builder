import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:future_builder/models/user.dart';
import 'package:http/http.dart' as http;

class UserApp extends ChangeNotifier {
  final baseUri = 'https://jsonplaceholder.typicode.com/users';
  late List<User> users = [];

  Future<List<User>> fetchUsers() async {
    final client = http.Client();
    final request = await client.get(Uri.parse(baseUri));
    final listOfJson = json.decode(request.body) as List<dynamic>;
    for (var user in listOfJson) {
      users.add(User.fromJson(user));
    }
    /** Attente de 10 s et le tableau est vide*/
    // return Future.delayed(const Duration(seconds: 10), () => []);
    /** Attente de 10 s*/
    //return Future.delayed(const Duration(seconds: 30), () => users);
    /** Cas OK */
    return users;
  }
}
