import 'Product.dart';
import 'Setting.dart';

void main() async {
  // EXERCISE 5: FACTORY CONSTRUCTORS & CACHE
  print('--- Exercise 5: Factory Constructors & Cache ---');
  final productRepo = ProductRepository();
  // Instantiate settings configurations
  final settingsInstanceA = Settings();
  final settingsInstanceB = Settings();

  // Modify property on one instance variable
  settingsInstanceA.themeMode = 'Dark Mode';

  print('Settings Instance A Theme: ${settingsInstanceA.themeMode}');
  print('Settings Instance B Theme: ${settingsInstanceB.themeMode}');

  // Verify singleton memory allocation using identity comparison
  bool isIdentical = identical(settingsInstanceA, settingsInstanceB);
  print('Are both instances pointing to the exact same object memory footprint? -> $isIdentical');

  // Clean up resource allocations
  productRepo.dispose();
}

