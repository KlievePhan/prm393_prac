import 'dart:async';
import 'dart:convert';
class User {
  final String name;
  final String email;

  User(this.name, this.email);

  // Factory constructor to handle automated serialization maps safely
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['name'] as String,
      json['email'] as String,
    );
  }
}

class UserRepository {
  Future<List<User>> fetchUsersFromApi() async {
    // Simulated Raw JSON payload payload from an HTTP network request response
    const String rawMockJsonResponse = '''
    [
      {"name": "Phan Anh", "email": "phananh@example.com"},
      {"name": "David C", "email": "davidC@example.com"}
    ]
    ''';

    await Future.delayed(Duration(milliseconds: 200)); // Simulating network transmission delay

    // Decode String payload into dynamic architecture object tree lists
    final List<dynamic> decodedJsonList = jsonDecode(rawMockJsonResponse) as List<dynamic>;

    // Convert raw maps inside iterable list cleanly into type-safe User structural model objects
    return decodedJsonList
        .map((jsonItem) => User.fromJson(jsonItem as Map<String, dynamic>))
        .toList();
  }
}