import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/library_provider.dart';
import 'screens/home_screen.dart';
import 'screens/reader_screen.dart';
import 'services/book_service.dart';
import 'services/hive_service.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final hiveService = HiveService();
  await hiveService.init();

  final bookService = BookService();
  final libraryProvider = LibraryProvider(
    bookService: bookService,
    hiveService: hiveService,
  );
  await libraryProvider.load();

  runApp(BookReaderApp(libraryProvider: libraryProvider));
}

class BookReaderApp extends StatelessWidget {
  const BookReaderApp({super.key, required this.libraryProvider});

  final LibraryProvider libraryProvider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: libraryProvider,
      child: MaterialApp(
        title: 'Book Reader',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const HomeScreen(),
        onGenerateRoute: (settings) {
          if (settings.name == '/reader') {
            final args = settings.arguments as Map<String, dynamic>;
            final bookId = args['bookId'] as String;
            final chapterIndex = args['chapterIndex'] as int;
            final pageIndex = args['pageIndex'] as int;

            final book = libraryProvider.bookById(bookId);
            if (book == null) {
              return MaterialPageRoute<void>(
                builder: (_) => const Scaffold(
                  body: Center(child: Text('Book not found')),
                ),
              );
            }

            return MaterialPageRoute<void>(
              builder: (_) => ReaderScreen(
                book: book,
                initialChapter: chapterIndex,
                initialPage: pageIndex,
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}
