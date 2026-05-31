import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../providers/library_provider.dart';
import '../widgets/book_card.dart';
import 'detail_screen.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key, this.initialTab = 0});

  final int initialTab;

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTab.clamp(0, 1),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final library = context.watch<LibraryProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Collections'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Favorites'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _BookGrid(
            books: library.favoriteBooks,
            emptyMessage: 'Tap the heart on a book to add it here.',
          ),
          _BookGrid(
            books: library.recentBooks,
            emptyMessage: 'Your recently opened books will show up here.',
          ),
        ],
      ),
    );
  }
}

class _BookGrid extends StatelessWidget {
  const _BookGrid({required this.books, required this.emptyMessage});

  final List<Book> books;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            emptyMessage,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 24,
        crossAxisSpacing: 20,
        childAspectRatio: 0.62,
      ),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return BookCard(
          book: book,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => DetailScreen(book: book),
              ),
            );
          },
        );
      },
    );
  }
}
