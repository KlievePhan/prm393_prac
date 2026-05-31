import 'package:flutter/material.dart';

class BookCover extends StatelessWidget {
  const BookCover({
    super.key,
    required this.title,
    required this.author,
    required this.coverHue,
    this.width = 100,
    this.height = 150,
  });

  final String title;
  final String author;
  final double coverHue;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final color = HSLColor.fromAHSL(1, coverHue, 0.45, 0.42).toColor();
    final dark = HSLColor.fromAHSL(1, coverHue, 0.5, 0.32).toColor();

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, dark],
        ),
        boxShadow: [
          BoxShadow(
            color: dark.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Text(
            title,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            author,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
