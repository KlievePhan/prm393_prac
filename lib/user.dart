class User {
  int userId;
  String email;

  User(this.userId, this.email);

  void displayInfo() {
    print('ID: $userId | Email: $email');
  }
}