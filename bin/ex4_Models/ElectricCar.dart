import 'Car.dart';
class ElectricCar extends Car {
  int batteryCapacity;

  ElectricCar(String model, this.batteryCapacity) : super(model);

  // Method Overriding
  @override
  void drive() {
    print('$model (Electric) is driving with $batteryCapacity kWh battery!');
  }
}