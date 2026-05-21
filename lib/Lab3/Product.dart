import 'dart:async';

class Product {
  final int id;
  final String name;
  final double price;

  Product(this.id, this.name, this.price);
}

class ProductRepository {
  // Hardcoded in-memory inventory
  final List<Product> _products = [
    Product(1, 'iPhone 15', 999.00),
    Product(2, 'AirPods Pro', 249.00)
  ];

  // Broadcast controller allows multiple stream listeners simultaneously
  final StreamController<Product> _productStreamController = StreamController<Product>.broadcast();

  // Future API implementation
  Future<List<Product>> getAll() async {
    await Future.delayed(Duration(milliseconds: 50)); // Simulating small delay
    return _products;
  }

  // Stream API implementation
  Stream<Product> liveAdded() {
    return _productStreamController.stream;
  }

  // Multi-behavior triggers
  void addNewProduct(Product product) {
    _products.add(product);
    _productStreamController.add(product); // Notify active stream listeners instantly
  }

  void dispose() {
    _productStreamController.close(); // Clean up stream connection to prevent memory leaks
  }
}