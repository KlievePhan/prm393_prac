void main() {
  print('1. LIST');
  List<String> frameworks = ['Flutter', 'React Native', 'Android Native'];

  frameworks.add('iOS Swift');
  frameworks.removeAt(1);
  print('1st Framework: ${frameworks[0]}');
  for (var tech in frameworks) {
    print('Learn: $tech');
  }

  print('\n2. SET');
  Set<int> userIds = {101, 102, 103, 101, 102};

  userIds.add(103);
  userIds.add(104);

  print('ID Set: ${userIds.length}'); // Sẽ là 4 thay vì 6
  print('Set of ID: $userIds');

  bool hasUser = userIds.contains(105);
  print('Does id 105 exist? $hasUser');


  print('\n3. MAP');
  Map<String, dynamic> project = {
    'id': 1,
    'title': 'ShoppingWeb',
    'isCompleted': false,
  };

  project['version'] = '1.0.2';
  project['isCompleted'] = true;

  print('Project name: ${project['title']}');

  project.forEach((key, value) {
    print('Key: $key | Value: $value');
  });
}