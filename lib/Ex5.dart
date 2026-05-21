void main() async {
  print('\nExercise 5');

  // Null safety practice
  String? username; // Nullable variable
  print('User display name: ${username ?? "Guest User"}'); // ?? operator (fallback)

  // Async/Await with Future
  print('System: Loading remote data...');
  String data = await fetchData(); // Waits for 2 seconds
  print('Response: $data');

  // Streams: Listening to a sequence of values
  print('Starting count stream:');
  await for (int val in countStream(3)) {
    print('Stream received value: $val');
  }
}

// Asynchronous function (Future)
Future<String> fetchData() async {
  // Simulating a network delay
  await Future.delayed(Duration(seconds: 2));
  return 'Connection established. Data downloaded.';
}

// Stream generator
Stream<int> countStream(int max) async* {
  for (int i = 1; i <= max; i++) {
    await Future.delayed(Duration(milliseconds: 500));
    yield i; // Yielding values to the stream
  }
}