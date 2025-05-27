import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_project/models/user.dart';
import 'package:flutter_web_project/providers/user_provider.dart';
import 'package:flutter_web_project/src/user_transactions_page.dart';
import 'package:flutter_web_project/widgets/user_form_dialog.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  void _showUserFormDialog(BuildContext context, WidgetRef ref, {User? user}) {
    showDialog(
      context: context,
      builder: (context) => UserFormDialog(
        initialUser: user,
        onSubmit: (name, email) async {
          final repo = ref.read(userRepositoryProvider);
          if (user == null) {
            await repo.createUser(name, email);
          } else {
            await repo.updateUser(user.id, name, email);
          }
          ref.invalidate(userListProvider);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(userListProvider);
    final repo = ref.read(userRepositoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Expense Dashboard')),
      body: usersAsync.when(
        data: (users) => Row(
          children: [
            Spacer(),
            Expanded(
              flex: 3,
              child: Card(
                color: Colors.white,
                margin: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: .2),
                                blurRadius: 6,
                                offset: Offset(2, 3),
                              ),
                            ],
                            color: Colors.transparent,
                          ),
                          child: TextButton.icon(
                            icon: Icon(Icons.add),
                            onPressed: () => _showUserFormDialog(context, ref),
                            label: const Text('Add User'),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor:
                                  Theme.of(context).dialogBackgroundColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      flex: 3,
                      child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final User user = users[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ListTile(
                              title: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => UserTransactionsPage(
                                            userId: user.id,
                                            userName: user.name,
                                          ),
                                        ),
                                      );
                                      // Refresh user list after returning
                                      ref.invalidate(userListProvider);
                                    },
                                    child: Text(
                                      user.name,
                                      style: TextStyle(
                                        fontSize: 20,
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue,
                                      ),
                                    )),
                              ),
                              subtitle: Text(
                                'Income: \$${user.totalIncome} | Expense: \$${user.totalExpense}',
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () => _showUserFormDialog(
                                        context, ref,
                                        user: user),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () async {
                                      await repo.deleteUser(user.id);
                                      ref.invalidate(userListProvider);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Spacer()
                  ],
                ),
              ),
            ),
            Spacer(),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
