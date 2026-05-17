import 'dart:async';

void main() async{
  print('\n--- Exercise 2 ---');
  List<int> scores = [85, 90, 78];
  scores.add(92); // Add a new score

  // Set: Automatically removes duplicate values
  Set<String> tags = {'flutter', 'dart', 'mobile', 'flutter'};

  // Map: Key-Value pairs
  Map<String, String> config = {
    'env': 'production',
    'version': '1.0.1'
  };

  int total = scores[0] + scores[1];
  String resultMsg = (total > 150) ? "Pass!" : "Try Again!";

  print('List of scores: $scores');
  print('Set tags: $tags');
  print('Map config: $config');
  print('Operator result: $total -> $resultMsg');
}