import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../providers/library_provider.dart';
import '../widgets/book_card.dart';
import '../widgets/continue_reading_card.dart';
import 'collection_screen.dart';
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openDetail(BuildContext context, Book book) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => DetailScreen(book: book),
      ),
    );
  }

  void _openReader(
    BuildContext context,
    Book book,
    int chapterIndex,
    int pageIndex,
  ) {
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

    if (library.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Library'),
        actions: [
          IconButton(
            icon: const Icon(Icons.collections_bookmark_outlined),
            tooltip: 'Collections',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const CollectionScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          ContinueReadingSection(
            onOpenBook: (book, chapter, page) =>
                _openReader(context, book, chapter, page),
          ),
          if (library.continueReadingBookmark != null)
            const SizedBox(height: 28),
          _SectionHeader(
            title: 'Recent',
            action: library.recentBooks.isEmpty
                ? null
                : () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const CollectionScreen(
                          initialTab: 1,
                        ),
                      ),
                    ),
          ),
          const SizedBox(height: 12),
          if (library.recentBooks.isEmpty)
            const _EmptyHint('Books you open will appear here.')
          else
            SizedBox(
              height: 220,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: library.recentBooks.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final book = library.recentBooks[index];
                  return BookCard(
                    book: book,
                    onTap: () => _openDetail(context, book),
                  );
                },
              ),
            ),
          const SizedBox(height: 28),
          const _SectionHeader(title: 'All Books'),
          const SizedBox(height: 12),
          ...library.books.map(
            (book) => _BookListTile(
              book: book,
              isFavorite: library.isFavorite(book.id),
              onTap: () => _openDetail(context, book),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.action});

  final String title;
  final VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const Spacer(),
        if (action != null)
          TextButton(onPressed: action, child: const Text('See all')),
      ],
    );
  }
}

class _EmptyHint extends StatelessWidget {
  const _EmptyHint(this.message);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}

class _BookListTile extends StatelessWidget {
  const _BookListTile({
    required this.book,
    required this.isFavorite,
    required this.onTap,
  });

  final Book book;
  final bool isFavorite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(book.title),
        subtitle: Text('${book.author} · ${book.totalPages} pages'),
        trailing: isFavorite
            ? Icon(Icons.favorite, color: Theme.of(context).colorScheme.primary, size: 20)
            : null,
        onTap: onTap,
      ),
    );
  }
}
