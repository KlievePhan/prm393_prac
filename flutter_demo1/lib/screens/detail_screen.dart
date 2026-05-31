import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../providers/library_provider.dart';
import '../widgets/book_cover.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.book});

  final Book book;

  void _openReader(
    BuildContext context, {
    int chapterIndex = 0,
    int pageIndex = 0,
  }) {
    context.read<LibraryProvider>().markRecent(book.id);
    Navigator.of(context).pushNamed(
      '/reader',
      arguments: {
        'bookId': book.id,
        'chapterIndex': chapterIndex,
        'pageIndex': pageIndex,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final library = context.watch<LibraryProvider>();
    final bookmark = library.bookmarkFor(book.id);
    final isFavorite = library.isFavorite(book.id);

    final startChapter = bookmark?.chapterIndex ?? 0;
    final startPage = bookmark?.pageIndex ?? 0;
    final progress = bookmark != null
        ? book.progressFor(startChapter, startPage)
        : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Theme.of(context).colorScheme.primary : null,
            ),
            onPressed: () => library.toggleFavorite(book.id),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
        children: [
          Center(
            child: BookCover(
              title: book.title,
              author: book.author,
              coverHue: book.coverHue,
              width: 160,
              height: 240,
            ),
          ),
          const SizedBox(height: 24),
          Text(book.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 4),
          Text(book.author, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16),
          Text(book.description, style: Theme.of(context).textTheme.bodyLarge),
          if (bookmark != null) ...[
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(value: progress, minHeight: 4),
            ),
            const SizedBox(height: 6),
            Text(
              '${(progress * 100).round()}% read',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => _openReader(
              context,
              chapterIndex: startChapter,
              pageIndex: startPage,
            ),
            icon: const Icon(Icons.menu_book_outlined),
            label: Text(bookmark != null ? 'Continue Reading' : 'Start Reading'),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
            ),
          ),
          const SizedBox(height: 32),
          Text('Table of Contents', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          ...List.generate(book.chapters.length, (index) {
            final chapter = book.chapters[index];
            final isCurrent = bookmark?.chapterIndex == index;
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 16,
                  child: Text('${index + 1}'),
                ),
                title: Text(chapter.title),
                subtitle: Text('${chapter.pages.length} pages'),
                trailing: isCurrent
                    ? Icon(
                        Icons.bookmark,
                        color: Theme.of(context).colorScheme.primary,
                        size: 20,
                      )
                    : const Icon(Icons.chevron_right, size: 20),
                onTap: () => _openReader(
                  context,
                  chapterIndex: index,
                  pageIndex: 0,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
