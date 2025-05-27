import 'dart:convert';
import 'package:flutter_web_project/models/transaction.dart';
import 'package:http/http.dart' as http;

class TransactionRepository {
  final _headers = {'Content-Type': 'application/json'};
  final String baseUrl = "http://localhost:8080";

  Future<List<Transaction>> getTransactionsByUser(int userId) async {
    final res =
        await http.get(Uri.parse('$baseUrl/users/$userId/transactions'));
    if (res.statusCode == 200) {
      final List data = json.decode(res.body);
      return data.map((e) => Transaction.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  Future<bool> createTransaction(Transaction tx) async {
    final res = await http.post(
      Uri.parse('$baseUrl/transactions'),
      headers: _headers,
      body: json.encode(tx.toJson()),
    );
    return res.statusCode == 200;
  }

  Future<bool> updateTransaction(int id, Transaction tx) async {
    final res = await http.put(
      Uri.parse('$baseUrl/transactions/$id'),
      headers: _headers,
      body: json.encode(tx.toJson()),
    );
    return res.statusCode == 200;
  }

  Future<bool> deleteTransaction(int id) async {
    final res = await http.delete(Uri.parse('$baseUrl/transactions/$id'));
    return res.statusCode == 200;
  }
}
