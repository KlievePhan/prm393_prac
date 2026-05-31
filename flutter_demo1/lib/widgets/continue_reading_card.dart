import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../providers/library_provider.dart';
import 'book_cover.dart';

class ContinueReadingCard extends StatelessWidget {
  const ContinueReadingCard({
    super.key,
    required this.book,
    required this.chapterTitle,
    required this.progress,
    required this.onTap,
  });

  final Book book;
  final String chapterTitle;
  final double progress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              BookCover(
                title: book.title,
                author: book.author,
                coverHue: book.coverHue,
                width: 72,
                height: 108,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Continue Reading',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      book.title,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      chapterTitle,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 4,
                        backgroundColor:
                            Theme.of(context).dividerColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${(progress * 100).round()}% complete',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

class ContinueReadingSection extends StatelessWidget {
  const ContinueReadingSection({super.key, required this.onOpenBook});

  final void Function(Book book, int chapterIndex, int pageIndex) onOpenBook;

  @override
  Widget build(BuildContext context) {
    final library = context.watch<LibraryProvider>();
    final bookmark = library.continueReadingBookmark;
    if (bookmark == null) return const SizedBox.shrink();

    final book = library.bookById(bookmark.bookId);
    if (book == null) return const SizedBox.shrink();

    final chapter = book.chapters[bookmark.chapterIndex];
    final progress = book.progressFor(
      bookmark.chapterIndex,
      bookmark.pageIndex,
    );

    return ContinueReadingCard(
      book: book,
      chapterTitle: chapter.title,
      progress: progress,
      onTap: () => onOpenBook(
        book,
        bookmark.chapterIndex,
        bookmark.pageIndex,
      ),
    );
  }
}
