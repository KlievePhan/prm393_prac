import 'dart:async';
import 'dart:convert';
void main() async {
  // EXERCISE 3: ASYNC + MICROTASK DEBUGGING
  print('--- Exercise 3: Async + Microtask Debugging ---');

  print('1. Code execution starts (Synchronous)');

  // Event Queue: Future callbacks are pushed onto the event queue
  Future(() {
    print('5. Future callback executed (Event Queue)');
  });

  // Microtask Queue: Microtasks have higher priority than the Event Queue
  scheduleMicrotask(() {
    print('3. Microtask callback executed (Microtask Queue)');
  });

  print('2. Code execution ends (Synchronous block finished)');

  await Future.delayed(Duration(milliseconds: 100));
  print('4. Sync buffer completed');
}