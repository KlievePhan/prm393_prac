import 'user.dart';

class Student extends User {
  int age;
  String className;

  Student(int userId, String email, this.age, this.className) : super(userId, email);

  @override
  void displayInfo() {
    print('Student - ID: $userId | Email: $email | Tuổi: $age | Lớp: $className');
  }
}