import 'user.dart';

class Teacher extends User {
  String major;
  int yoe;

  Teacher(int userId, String email, this.major, this.yoe) : super(userId, email);

  @override
  void displayInfo() {
    print('Teacher - ID: $userId | Email: $email | Chuyên môn: $major | Kinh nghiệm: $yoe năm');
  }
}