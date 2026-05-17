class Car {
  String model;

  // Standard Constructor
  Car(this.model);

  // Named Constructor
  Car.named(this.model) {
    print('Named Constructor: Initializing $model');
  }

  void drive() {
    print('$model is driving on the road.');
  }
}