class Transaction {
  final int id;
  final int userId;
  final String type;
  final String category;
  final double amount;

  Transaction({
    required this.id,
    required this.userId,
    required this.type,
    required this.category,
    required this.amount,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      userId: json['user_id'],
      type: json['type'],
      category: json['category'],
      amount: (json['amount'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'type': type,
      'category': category,
      'amount': amount,
    };
  }
}
