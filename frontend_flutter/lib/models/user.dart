import 'package:flutter_web_project/models/transaction.dart';

class User {
  final int id;
  final String name;
  final String email;
  final double totalIncome;
  final double totalExpense;
  final List<Transaction> transactions;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.totalIncome,
    required this.totalExpense,
    required this.transactions,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        totalIncome: (json['total_income'] ?? 0).toDouble(),
        totalExpense: (json['total_expense'] ?? 0).toDouble(),
        transactions: (json['transactions'] as List<dynamic>? ?? [])
            .map((tx) => Transaction.fromJson(tx))
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'total_income': totalIncome,
      'total_expense': totalExpense,
      'transactions': transactions.map((tx) => tx.toJson()).toList(),
    };
  }
}
