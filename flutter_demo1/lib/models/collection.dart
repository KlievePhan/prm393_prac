/// In-memory view of user collections (favorites + recent), backed by Hive.
class LibraryCollection {
  const LibraryCollection({
    required this.favoriteIds,
    required this.recentIds,
  });

  final List<String> favoriteIds;
  final List<String> recentIds;

  bool isFavorite(String bookId) => favoriteIds.contains(bookId);
}
