import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_project/models/transaction.dart';
import 'package:flutter_web_project/repositories/transaction_repository.dart';

// Provide the TransactionRepository
final transactionRepositoryProvider = Provider((ref) => TransactionRepository());

// List of transactions for a given user
final userTransactionsProvider = FutureProvider.family<List<Transaction>, int>((ref, userId) async {
  final repo = ref.read(transactionRepositoryProvider);
  return repo.getTransactionsByUser(userId);
});
