import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// AppTheme - The complete visual identity of CycleAI.
class AppTheme {
  AppTheme._();

  // ─────────────────────────────────────────────────────────────────
  // LIGHT THEME
  // ─────────────────────────────────────────────────────────────────
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        error: AppColors.error,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.grey50,

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.grey900,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.grey900,
          fontSize: 17.0,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: IconThemeData(
          color: AppColors.grey900,
          size: 24.0,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          minimumSize: const Size(double.infinity, 56.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          textStyle: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
          ),
          elevation: 0,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          minimumSize: const Size(double.infinity, 56.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          textStyle: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColors.grey300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColors.grey300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        labelStyle: const TextStyle(
          color: AppColors.grey600,
          fontSize: 15.0,
        ),
        hintStyle: const TextStyle(
          color: AppColors.grey400,
          fontSize: 15.0,
        ),
        errorStyle: const TextStyle(
          color: AppColors.error,
          fontSize: 13.0,
        ),
      ),

      cardTheme: CardThemeData(
        color: AppColors.white,
        elevation: 2,
        shadowColor: AppColors.grey300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 4.0,
        ),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey500,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 8,
      ),

      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.w800,
          color: AppColors.grey900,
          height: 1.2,
        ),
        headlineMedium: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
          color: AppColors.grey900,
          height: 1.3,
        ),
        titleLarge: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          color: AppColors.grey900,
        ),
        titleMedium: TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.w600,
          color: AppColors.grey800,
        ),
        bodyLarge: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
          color: AppColors.grey700,
          height: 1.6,
        ),
        bodyMedium: TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.w400,
          color: AppColors.grey600,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          fontSize: 11.0,
          fontWeight: FontWeight.w400,
          color: AppColors.grey500,
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.grey900,
        contentTextStyle: const TextStyle(
          color: AppColors.white,
          fontSize: 13.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 6,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.grey100,
        selectedColor: AppColors.primaryLight,
        labelStyle: const TextStyle(fontSize: 13.0),
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 4.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
          side: const BorderSide(color: AppColors.grey300),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.grey200,
        thickness: 1,
        space: 0,
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────
  // DARK THEME
  // ─────────────────────────────────────────────────────────────────
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      cardTheme: CardThemeData(
        color: const Color(0xFF1E1E1E),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }
}