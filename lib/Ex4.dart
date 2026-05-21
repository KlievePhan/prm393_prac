import 'ex4_Models/Car.dart';
import 'ex4_Models/ElectricCar.dart';

void main() async {
  //Practice inheritance, constructors, and method overriding.
  print('\nExercise 4');

// Named Constructor
  var myOldCar = Car.named("Porsche GT3 RS");
  myOldCar.drive();

// Inheritance and Overriding
  var myTesla = ElectricCar("Tesla Model 3", 75);
  myTesla.drive(); // Executing the overridden method
  print('Battery Capacity: ${myTesla.batteryCapacity} kWh');
}