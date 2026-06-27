import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_constants.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppConstants.backgroundColor,
      primaryColor: AppConstants.primaryColor,
      colorScheme: const ColorScheme.light(
        primary: AppConstants.primaryColor,
        surface: AppConstants.backgroundColor,
        surfaceContainer: AppConstants.cardColor,
        onPrimary: Colors.white,
        secondary: AppConstants.primaryColor,
      ),
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        titleLarge: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppConstants.textDarkColor,
        ),
        titleMedium: const TextStyle(
          fontWeight: FontWeight.w600,
          color: AppConstants.textDarkColor,
        ),
        bodyLarge: const TextStyle(
          color: AppConstants.textDarkColor,
        ),
        bodyMedium: const TextStyle(
          color: AppConstants.textLightColor,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppConstants.cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFF0F172A), // Sleek Slate/Blue dark mode bg
      primaryColor: AppConstants.primaryColor,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppConstants.primaryColor,
        surface: Color(0xFF0F172A),
        surfaceContainer: Color(0xFF1E293B), // Card container dark color
        onPrimary: Colors.white,
        secondary: AppConstants.primaryColor,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).copyWith(
        titleLarge: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titleMedium: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        bodyLarge: const TextStyle(
          color: Colors.white,
        ),
        bodyMedium: const TextStyle(
          color: Color(0xFFA3AED0),
        ),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF1E293B),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
      ),
    );
  }
}
