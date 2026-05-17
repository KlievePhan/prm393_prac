import 'user.dart';

class Teacher extends User {
  final String _major;
  int yoe;

  Teacher(int userId, String email, this._major, this.yoe) : super(userId, email);

  @override
  void displayInfo() {
    print('Teacher - ID: $userId | Email: $email | Chuyên môn: $_major | Kinh nghiệm: $yoe năm');
  }
}