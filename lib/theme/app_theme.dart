import 'package:flutter/material.dart';

class AppColors {
  static const Color bgTop = Color(0xFF4A1F7A);
  static const Color bgMid = Color(0xFF2B1054);
  static const Color bgBottom = Color(0xFF1A0833);
  static const Color accent = Color(0xFFB388FF);
  static const Color accentStrong = Color(0xFF8E4DFF);
  static const Color surface = Color(0xFF2C1250);
  static const Color textSoft = Color(0xFFD9C8F5);
}

class AppTheme {
  static ThemeData get theme {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.accentStrong,
      brightness: Brightness.dark,
    ).copyWith(
      primary: AppColors.accent,
      onPrimary: AppColors.bgBottom,
      surface: AppColors.surface,
    );

    OutlineInputBorder border(Color color, [double width = 1]) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      // Transparan supaya gradient ungu di belakangnya terlihat
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.08),
        labelStyle: const TextStyle(color: AppColors.textSoft),
        prefixIconColor: AppColors.textSoft,
        suffixIconColor: AppColors.textSoft,
        border: border(Colors.white.withValues(alpha: 0.25)),
        enabledBorder: border(Colors.white.withValues(alpha: 0.25)),
        focusedBorder: border(AppColors.accent, 1.6),
        errorBorder: border(Colors.pinkAccent),
        focusedErrorBorder: border(Colors.pinkAccent, 1.6),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentStrong,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.accent),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.accentStrong,
        foregroundColor: Colors.white,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.accent,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surface,
        contentTextStyle: const TextStyle(color: Colors.white),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}