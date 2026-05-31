import 'package:flutter/foundation.dart';

import '../models/book.dart';
import '../models/bookmark.dart';
import '../models/collection.dart';
import '../services/book_service.dart';
import '../services/hive_service.dart';

class LibraryProvider extends ChangeNotifier {
  LibraryProvider({
    required BookService bookService,
    required HiveService hiveService,
  })  : _bookService = bookService,
        _hiveService = hiveService;

  final BookService _bookService;
  final HiveService _hiveService;

  List<Book> _books = [];
  bool _loading = true;

  List<Book> get books => _books;
  bool get isLoading => _loading;

  LibraryCollection get collection => LibraryCollection(
        favoriteIds: _hiveService.favoriteIds,
        recentIds: _hiveService.recentIds,
      );

  Bookmark? get continueReadingBookmark => _hiveService.latestBookmark;

  Future<void> load() async {
    _loading = true;
    notifyListeners();
    _books = await _bookService.loadBooks();
    _loading = false;
    notifyListeners();
  }

  Book? bookById(String id) {
    try {
      return _books.firstWhere((b) => b.id == id);
    } catch (_) {
      return null;
    }
  }

  Bookmark? bookmarkFor(String bookId) => _hiveService.getBookmark(bookId);

  List<Book> get recentBooks {
    return collection.recentIds
        .map(bookById)
        .whereType<Book>()
        .toList();
  }

  List<Book> get favoriteBooks {
    return collection.favoriteIds
        .map(bookById)
        .whereType<Book>()
        .toList();
  }

  bool isFavorite(String bookId) => _hiveService.isFavorite(bookId);

  Future<void> toggleFavorite(String bookId) async {
    await _hiveService.toggleFavorite(bookId);
    notifyListeners();
  }

  Future<void> savePosition({
    required String bookId,
    required int chapterIndex,
    required int pageIndex,
  }) async {
    await _hiveService.saveReadingPosition(
      bookId: bookId,
      chapterIndex: chapterIndex,
      pageIndex: pageIndex,
    );
    notifyListeners();
  }

  Future<void> markRecent(String bookId) async {
    await _hiveService.addRecent(bookId);
    notifyListeners();
  }
}
