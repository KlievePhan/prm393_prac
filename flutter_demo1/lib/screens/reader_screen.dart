import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../providers/library_provider.dart';

class ReaderScreen extends StatefulWidget {
  const ReaderScreen({
    super.key,
    required this.book,
    required this.initialChapter,
    required this.initialPage,
  });

  final Book book;
  final int initialChapter;
  final int initialPage;

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  late int _chapterIndex;
  late int _pageIndex;

  @override
  void initState() {
    super.initState();
    _chapterIndex = widget.initialChapter;
    _pageIndex = widget.initialPage;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _persistPosition();
    });
  }

  Chapter get _chapter => widget.book.chapters[_chapterIndex];

  bool get _hasPrevious => _chapterIndex > 0 || _pageIndex > 0;

  bool get _hasNext {
    final lastChapter = widget.book.chapters.length - 1;
    final lastPage = widget.book.chapters[lastChapter].pages.length - 1;
    return _chapterIndex < lastChapter ||
        (_chapterIndex == lastChapter && _pageIndex < lastPage);
  }

  double get _progress =>
      widget.book.progressFor(_chapterIndex, _pageIndex);

  Future<void> _persistPosition() async {
    await context.read<LibraryProvider>().savePosition(
          bookId: widget.book.id,
          chapterIndex: _chapterIndex,
          pageIndex: _pageIndex,
        );
  }

  void _goPrevious() {
    if (!_hasPrevious) return;
    setState(() {
      if (_pageIndex > 0) {
        _pageIndex--;
      } else {
        _chapterIndex--;
        _pageIndex = widget.book.chapters[_chapterIndex].pages.length - 1;
      }
    });
    _persistPosition();
  }

  void _goNext() {
    if (!_hasNext) return;
    setState(() {
      final pageCount = _chapter.pages.length;
      if (_pageIndex < pageCount - 1) {
        _pageIndex++;
      } else {
        _chapterIndex++;
        _pageIndex = 0;
      }
    });
    _persistPosition();
  }

  Future<void> _jumpToChapter(int index) async {
    setState(() {
      _chapterIndex = index;
      _pageIndex = 0;
    });
    await _persistPosition();
    if (mounted) Navigator.of(context).pop();
  }

  void _showToc() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Table of Contents',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              ...List.generate(widget.book.chapters.length, (index) {
                final chapter = widget.book.chapters[index];
                final selected = index == _chapterIndex;
                return ListTile(
                  selected: selected,
                  title: Text(chapter.title),
                  subtitle: Text('${chapter.pages.length} pages'),
                  trailing: selected ? const Icon(Icons.check) : null,
                  onTap: () => _jumpToChapter(index),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final pageLabel =
        'Page ${_pageIndex + 1} of ${_chapter.pages.length}';
    final chapterLabel =
        'Chapter ${_chapterIndex + 1}: ${_chapter.title}';

    return Theme(
      data: Theme.of(context).copyWith(
        scaffoldBackgroundColor: const Color(0xFFFAF6F0),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.book.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.list),
              tooltip: 'Contents',
              onPressed: _showToc,
            ),
            IconButton(
              icon: const Icon(Icons.bookmark_add_outlined),
              tooltip: 'Save bookmark',
              onPressed: () async {
                await _persistPosition();
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Reading position saved'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(value: _progress, minHeight: 3),
                  const SizedBox(height: 8),
                  Text(
                    '${(_progress * 100).round()}% · $chapterLabel',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: Text(
                  _chapter.pages[_pageIndex],
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 19,
                        height: 1.7,
                      ),
                ),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
              child: Row(
                children: [
                  TextButton.icon(
                    onPressed: _hasPrevious ? _goPrevious : null,
                    icon: const Icon(Icons.chevron_left),
                    label: const Text('Previous'),
                  ),
                  Expanded(
                    child: Text(
                      pageLabel,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _hasNext ? _goNext : null,
                    icon: const Icon(Icons.chevron_right),
                    label: const Text('Next'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
