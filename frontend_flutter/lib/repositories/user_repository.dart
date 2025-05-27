import 'dart:convert';

import 'package:flutter_web_project/models/user.dart';
import 'package:flutter_web_project/services/http_client.dart';

class UserRepository {
  final String baseUrl = "http://localhost:8080";
  final _client = HttpClient().client;

  Future<List<User>> fetchUsers() async {
    final res = await _client.get(Uri.parse('$baseUrl/users'));
    if (res.statusCode == 200) {
      final List<dynamic> data = json.decode(res.body);
      return data.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<bool> deleteUser(int id) async {
    final res = await _client.delete(Uri.parse('$baseUrl/users/$id'));
    if (res.statusCode != 200) {
      throw Exception('Failed to delete user');
    } else {
      return true;
    }
  }

  Future<void> createUser(String name, String email) async {
    final res = await _client.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name, 'email': email}),
    );
    if (res.statusCode != 200) {
      throw Exception('Failed to create user');
    }
  }

  Future<void> updateUser(int id, String name, String email) async {
    final res = await _client.put(
      Uri.parse('$baseUrl/users/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name, 'email': email}),
    );
    if (res.statusCode != 200) {
      throw Exception('Failed to update user');
    }
  }
}
