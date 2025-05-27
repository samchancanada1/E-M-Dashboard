import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_project/models/user.dart';
import 'package:flutter_web_project/repositories/user_repository.dart';

final userRepositoryProvider = Provider((ref) => UserRepository());

final userListProvider = FutureProvider<List<User>>((ref) async {
  final repo = ref.read(userRepositoryProvider);
  return repo.fetchUsers();
});
