import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/book.dart';

class BookService {
  static const _assetPaths = [
    'assets/books/atomic_habits.json',
    'assets/books/the_alchemist.json',
    'assets/books/pride_and_prejudice.json',
  ];

  List<Book>? _cache;

  Future<List<Book>> loadBooks() async {
    if (_cache != null) return _cache!;

    final books = <Book>[];
    for (final path in _assetPaths) {
      final raw = await rootBundle.loadString(path);
      final json = jsonDecode(raw) as Map<String, dynamic>;
      books.add(Book.fromJson(json));
    }
    _cache = books;
    return books;
  }

  Future<Book?> getBook(String id) async {
    final books = await loadBooks();
    try {
      return books.firstWhere((b) => b.id == id);
    } catch (_) {
      return null;
    }
  }
}
