class User {
  final int id;
  final String name;
  final String email;
  final double totalIncome;
  final double totalExpense;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.totalIncome,
    required this.totalExpense,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      totalIncome: (json['total_income'] ?? 0).toDouble(),
      totalExpense: (json['total_expense'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'total_income': totalIncome,
      'total_expense': totalExpense,
    };
  }
}
