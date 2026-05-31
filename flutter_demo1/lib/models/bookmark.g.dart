part of 'bookmark.dart';

class BookmarkAdapter extends TypeAdapter<Bookmark> {
  @override
  final int typeId = 0;

  @override
  Bookmark read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bookmark(
      bookId: fields[0] as String,
      chapterIndex: fields[1] as int,
      pageIndex: fields[2] as int,
      lastReadMs: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Bookmark obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.bookId)
      ..writeByte(1)
      ..write(obj.chapterIndex)
      ..writeByte(2)
      ..write(obj.pageIndex)
      ..writeByte(3)
      ..write(obj.lastReadMs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookmarkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
