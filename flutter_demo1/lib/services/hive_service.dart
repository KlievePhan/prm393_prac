import 'package:hive_flutter/hive_flutter.dart';

import '../models/bookmark.dart';

class HiveService {
  static const _bookmarksBox = 'bookmarks';
  static const _favoritesBox = 'favorites';
  static const _recentBox = 'recent';

  Box<Bookmark>? _bookmarks;
  Box<String>? _favorites;
  Box<String>? _recent;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(BookmarkAdapter());
    _bookmarks = await Hive.openBox<Bookmark>(_bookmarksBox);
    _favorites = await Hive.openBox<String>(_favoritesBox);
    _recent = await Hive.openBox<String>(_recentBox);
  }

  Bookmark? getBookmark(String bookId) => _bookmarks?.get(bookId);

  List<Bookmark> get allBookmarks {
    final list = _bookmarks?.values.toList() ?? [];
    list.sort((a, b) => b.lastReadMs.compareTo(a.lastReadMs));
    return list;
  }

  Bookmark? get latestBookmark {
    final bookmarks = allBookmarks;
    return bookmarks.isEmpty ? null : bookmarks.first;
  }

  Future<void> saveBookmark(Bookmark bookmark) async {
    bookmark.touch();
    await _bookmarks?.put(bookmark.bookId, bookmark);
  }

  Future<void> saveReadingPosition({
    required String bookId,
    required int chapterIndex,
    required int pageIndex,
  }) async {
    final existing = getBookmark(bookId);
    if (existing != null) {
      existing
        ..chapterIndex = chapterIndex
        ..pageIndex = pageIndex
        ..touch();
      await existing.save();
    } else {
      await saveBookmark(
        Bookmark(
          bookId: bookId,
          chapterIndex: chapterIndex,
          pageIndex: pageIndex,
        ),
      );
    }
    await addRecent(bookId);
  }

  List<String> get favoriteIds => _favorites?.keys.cast<String>().toList() ?? [];

  bool isFavorite(String bookId) => _favorites?.containsKey(bookId) ?? false;

  Future<void> toggleFavorite(String bookId) async {
    if (isFavorite(bookId)) {
      await _favorites?.delete(bookId);
    } else {
      await _favorites?.put(bookId, bookId);
    }
  }

  List<String> get recentIds {
    final keys = _recent?.keys.cast<String>().toList() ?? [];
    keys.sort((a, b) {
      final aMs = int.tryParse(_recent?.get(a) ?? '0') ?? 0;
      final bMs = int.tryParse(_recent?.get(b) ?? '0') ?? 0;
      return bMs.compareTo(aMs);
    });
    return keys;
  }

  Future<void> addRecent(String bookId) async {
    await _recent?.put(bookId, DateTime.now().millisecondsSinceEpoch.toString());
  }
}
