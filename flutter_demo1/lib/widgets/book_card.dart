import 'package:flutter/material.dart';

import '../models/book.dart';
import 'book_cover.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.book,
    required this.onTap,
    this.trailing,
  });

  final Book book;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookCover(
              title: book.title,
              author: book.author,
              coverHue: book.coverHue,
              width: 120,
              height: 170,
            ),
            const SizedBox(height: 10),
            Text(
              book.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              book.author,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
