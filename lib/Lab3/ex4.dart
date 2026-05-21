import 'dart:async';
import 'dart:convert';
void main() async {
  // EXERCISE 4: STREAM TRANSFORMATION
  print('--- Exercise 4: Stream Transformation ---');

  // Create a stream of numbers 1 to 5
  final numberStream = Stream<int>.fromIterable([1, 2, 3, 4, 5]);

  // Transform stream: square the numbers, then filter only the even results
  final transformedStream = numberStream
      .map((number) => number * number)    // Squares: 1, 4, 9, 16, 25
      .where((squared) => squared % 2 == 0); // Filters even numbers: 4, 16

  // Listen to the stream events
  await for (var val in transformedStream) {
    print('Transform Stream Received Even Square: $val');
  }
}