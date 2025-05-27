import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_project/models/transaction.dart';
import 'package:flutter_web_project/providers/transaction_provider.dart';

class UserTransactionsPage extends ConsumerWidget {
  final int userId;
  final String userName;

  const UserTransactionsPage({
    super.key,
    required this.userId,
    required this.userName,
  });

  void _showTransactionForm(BuildContext context, WidgetRef ref,
      {Transaction? transaction}) {
    final typeCtrl = TextEditingController(text: transaction?.type ?? 'income');
    final categoryCtrl =
        TextEditingController(text: transaction?.category ?? '');
    final amountCtrl =
        TextEditingController(text: transaction?.amount.toString() ?? '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title:
            Text(transaction == null ? 'Add Transaction' : 'Edit Transaction'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: typeCtrl.text,
              onChanged: (value) => typeCtrl.text = value!,
              items: const [
                DropdownMenuItem(value: 'income', child: Text('Income')),
                DropdownMenuItem(value: 'expense', child: Text('Expense')),
              ],
              decoration: const InputDecoration(labelText: 'Type'),
            ),
            TextField(
              controller: categoryCtrl,
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            TextField(
              controller: amountCtrl,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final tx = Transaction(
                id: transaction?.id ?? 0,
                userId: userId,
                type: typeCtrl.text,
                category: categoryCtrl.text,
                amount: double.tryParse(amountCtrl.text) ?? 0,
              );

              final repo = ref.read(transactionRepositoryProvider);
              final ok = transaction == null
                  ? await repo.createTransaction(tx)
                  : await repo.updateTransaction(tx.id, tx);

              if (ok) {
                ref.invalidate(userTransactionsProvider(userId));
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Save failed')),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txList = ref.watch(userTransactionsProvider(userId));
    final repo = ref.read(transactionRepositoryProvider);

    return Scaffold(
      appBar: AppBar(title: Text('$userName\'s Transactions')),
      body: txList.when(
        data: (transactions) => Column(
          children: [
            ElevatedButton(
              onPressed: () => _showTransactionForm(context, ref),
              child: const Text('Add Transaction'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (_, i) {
                  final tx = transactions[i];
                  return ListTile(
                    title: Text('${tx.type} - ${tx.category}'),
                    subtitle: Text('\$${tx.amount.toStringAsFixed(2)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showTransactionForm(
                            context,
                            ref,
                            transaction: tx,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            await repo.deleteTransaction(tx.id);
                            ref.invalidate(userTransactionsProvider(userId));
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
