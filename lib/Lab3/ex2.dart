import 'dart:async';
import 'dart:convert';

import 'User.dart';
void main() async {
  // EXERCISE 2: USER REPOSITORY WITH JSON
  print('--- Exercise 2: User Repository with JSON ---');
  final userRepo = UserRepository();

  print('Simulating JSON API request...');
  final users = await userRepo.fetchUsersFromApi();
  for (var user in users) {
    print(' -> Parsed User Object: Name: "${user.name}" | Email: "${user.email}"');
  }
}
