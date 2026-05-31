class Book {
  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.coverHue,
    required this.chapters,
  });

  final String id;
  final String title;
  final String author;
  final String description;
  final double coverHue;
  final List<Chapter> chapters;

  int get totalPages =>
      chapters.fold(0, (sum, chapter) => sum + chapter.pages.length);

  factory Book.fromJson(Map<String, dynamic> json) {
    final chaptersJson = json['chapters'] as List<dynamic>;
    return Book(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      description: json['description'] as String,
      coverHue: (json['coverHue'] as num?)?.toDouble() ?? 200,
      chapters: chaptersJson
          .map((c) => Chapter.fromJson(c as Map<String, dynamic>))
          .toList(),
    );
  }

  String pageAt(int chapterIndex, int pageIndex) {
    return chapters[chapterIndex].pages[pageIndex];
  }

  /// Global page index across all chapters (0-based).
  int globalPageIndex(int chapterIndex, int pageIndex) {
    var index = 0;
    for (var c = 0; c < chapterIndex; c++) {
      index += chapters[c].pages.length;
    }
    return index + pageIndex;
  }

  double progressFor(int chapterIndex, int pageIndex) {
    if (totalPages == 0) return 0;
    return (globalPageIndex(chapterIndex, pageIndex) + 1) / totalPages;
  }

  (int chapterIndex, int pageIndex) positionFromGlobal(int globalIndex) {
    var remaining = globalIndex;
    for (var c = 0; c < chapters.length; c++) {
      final count = chapters[c].pages.length;
      if (remaining < count) {
        return (c, remaining);
      }
      remaining -= count;
    }
    final lastChapter = chapters.length - 1;
    final lastPage = chapters[lastChapter].pages.length - 1;
    return (lastChapter, lastPage);
  }
}

class Chapter {
  const Chapter({required this.title, required this.pages});

  final String title;
  final List<String> pages;

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      title: json['title'] as String,
      pages: (json['pages'] as List<dynamic>).cast<String>(),
    );
  }
}
