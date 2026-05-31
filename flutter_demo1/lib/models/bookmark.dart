import 'package:hive/hive.dart';

part 'bookmark.g.dart';

@HiveType(typeId: 0)
class Bookmark extends HiveObject {
  Bookmark({
    required this.bookId,
    required this.chapterIndex,
    required this.pageIndex,
    int? lastReadMs,
  }) : lastReadMs = lastReadMs ?? DateTime.now().millisecondsSinceEpoch;

  @HiveField(0)
  String bookId;

  @HiveField(1)
  int chapterIndex;

  @HiveField(2)
  int pageIndex;

  @HiveField(3)
  int lastReadMs;

  DateTime get lastReadAt => DateTime.fromMillisecondsSinceEpoch(lastReadMs);

  void touch() {
    lastReadMs = DateTime.now().millisecondsSinceEpoch;
  }
}
