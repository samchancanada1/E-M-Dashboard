import 'package:flutter/material.dart';
import 'package:flutter_web_project/models/user.dart';

class UserFormDialog extends StatefulWidget {
  final User? initialUser;
  final void Function(String name, String email) onSubmit;

  const UserFormDialog({
    super.key,
    this.initialUser,
    required this.onSubmit,
  });

  @override
  State<UserFormDialog> createState() => _UserFormDialogState();
}

class _UserFormDialogState extends State<UserFormDialog> {
  late TextEditingController nameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initialUser?.name ?? '');
    emailController = TextEditingController(text: widget.initialUser?.email ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialUser == null ? 'Add User' : 'Edit User'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onSubmit(nameController.text, emailController.text);
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
