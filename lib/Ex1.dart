import 'dart:async';

void main() async {

  // Ex1: BASIC SYNTAX & DATA TYPES
  // Declare variables & String Interpolation
  int age = 21;
  double gpa = 3.6;
  String name = "Antony";
  bool isJournalyst = true;

  print('Ex1:');
  print('Name: $name');
  print('Age: $age - GPA: $gpa');
  print('Is Journalyst: ${isJournalyst ? "Yes" : "Nope"}');
}