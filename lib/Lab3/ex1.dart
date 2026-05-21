import 'dart:async';
import 'Product.dart';
void main() async {
  // EXERCISE 1: PRODUCT MODEL & REPOSITORY
  print('--- Exercise 1: Product Model & Repository ---');
  final productRepo = ProductRepository();

  // Listen to the live stream of real-time added products
  productRepo.liveAdded().listen((product) {
    print(' [Live Stream Notification] New Product Added: ${product.name} (\$${product.price})');
  });

  // Fetch all existing products asynchronously
  print('Fetching all existing products...');
  final existingProducts = await productRepo.getAll();
  for (var p in existingProducts) {
    print(' - Fetched: ${p.name} (ID: ${p.id})');
  }

  // Simulate adding new products in real-time
  productRepo.addNewProduct(Product(3, 'MacBook Pro', 1999.99));
  productRepo.addNewProduct(Product(4, 'iPad Pro', 999.99));

  // Small delay to let asynchronous stream
  await Future.delayed(Duration(milliseconds: 100));
}

