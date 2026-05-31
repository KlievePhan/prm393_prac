import 'package:flutter/material.dart';

class AppTheme {
  static const _warmPaper = Color(0xFFF5F0E8);
  static const _warmPaperDark = Color(0xFF2C2824);
  static const _ink = Color(0xFF2B2520);
  static const _inkMuted = Color(0xFF6B635C);
  static const _accent = Color(0xFFC17F59);

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _accent,
        brightness: Brightness.light,
        surface: _warmPaper,
      ),
    );
    return base.copyWith(
      scaffoldBackgroundColor: _warmPaper,
      appBarTheme: const AppBarTheme(
        backgroundColor: _warmPaper,
        foregroundColor: _ink,
        elevation: 0,
        centerTitle: false,
      ),
      textTheme: base.textTheme.apply(
        bodyColor: _ink,
        displayColor: _ink,
        fontFamily: 'Georgia',
      ).copyWith(
        headlineMedium: const TextStyle(
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
          color: _ink,
        ),
        titleLarge: const TextStyle(fontWeight: FontWeight.w600, color: _ink),
        bodyLarge: const TextStyle(
          fontSize: 18,
          height: 1.65,
          color: _ink,
        ),
        bodyMedium: const TextStyle(color: _inkMuted, height: 1.5),
        labelLarge: const TextStyle(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white.withValues(alpha: 0.7),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      dividerColor: _ink.withValues(alpha: 0.08),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _accent,
        foregroundColor: Colors.white,
      ),
    );
  }

  static ThemeData get reader {
    return light.copyWith(
      scaffoldBackgroundColor: const Color(0xFFFAF6F0),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFAF6F0),
        foregroundColor: _ink,
        elevation: 0,
      ),
    );
  }
}
