import 'dart:async';

void main() async{
  List<int> scores = [85, 76, 67];
  int examScore = 85;
  if (examScore >= 80) {
    print('Grade: Good');
  } else {
    print('Grade: Average');
  }

  // Switch case for day of the week
  String day = "Monday";
  switch (day) {
    case "Monday" "Tuesday" "Wednesday" "Thursday" "Friday":
      print('Status: Weekday.');
      break;
    default:
      print('Status: Weekend.');
  }

  // Loops: Iteration
  print('Looping through scores:');
  for (var s in scores) {
    print(' - Score entry: $s');
  }

  // Functions: Arrow syntax
  int multiply(int a, int b) => a * b;
  print('Arrow Function result (5 x 6): ${multiply(5, 6)}');
}