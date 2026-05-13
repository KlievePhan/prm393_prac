import 'dart:io';
import 'package:practice_dart/student.dart';
import 'package:practice_dart/teacher.dart';

void main() {
  List<Student> students = [];
  List<Teacher> teachers = [];
  bool isRunning = true;

  while (isRunning) {
    print('\n--- QUẢN LÝ TRƯỜNG HỌC ---');
    print('1. Xem danh sách sinh viên');
    print('2. Xem danh sách giáo viên');
    print('3. Thêm sinh viên');
    print('4. Thêm giáo viên');
    print('0. Thoát');
    stdout.write('Chọn chức năng: ');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        print('\n--- DANH SÁCH SINH VIÊN ---');
        if (students.isEmpty) print('Trống.');
        for (var s in students) s.displayInfo();
        break;

      case '2':
        print('\n--- DANH SÁCH GIÁO VIÊN ---');
        if (teachers.isEmpty) print('Trống.');
        for (var t in teachers) t.displayInfo();
        break;

      case '3':
        stdout.write('Nhập ID: ');
        int id = int.parse(stdin.readLineSync()!);
        stdout.write('Nhập Email: ');
        String email = stdin.readLineSync()!;
        stdout.write('Nhập Tuổi: ');
        int age = int.parse(stdin.readLineSync()!);
        stdout.write('Nhập Lớp: ');
        String cls = stdin.readLineSync()!;

        students.add(Student(id, email, age, cls));
        print('Đã thêm sinh viên thành công!');
        break;

      case '4':
        stdout.write('Nhập ID: ');
        int id = int.parse(stdin.readLineSync()!);
        stdout.write('Nhập Email: ');
        String email = stdin.readLineSync()!;
        stdout.write('Nhập Chuyên môn: ');
        String major = stdin.readLineSync()!;
        stdout.write('Nhập Số năm kinh nghiệm: ');
        int yoe = int.parse(stdin.readLineSync()!);

        teachers.add(Teacher(id, email, major, yoe));
        print('Đã thêm giáo viên thành công!');
        break;

      case '0':
        isRunning = false;
        print('Tạm biệt!');
        break;

      default:
        print('Lựa chọn không hợp lệ!');
    }
  }
}