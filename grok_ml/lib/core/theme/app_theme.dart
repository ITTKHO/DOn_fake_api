// FILE: lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFFFC0CB), // Pastel pink
    primary: const Color(0xFFFFC0CB),
    secondary: const Color(0xFFFFE4E1),
    background: const Color(0xFFFFF5EE),
    surface: const Color(0xFFFFFAF0),
  ),
  textTheme: GoogleFonts.kanitTextTheme().copyWith(
    headlineMedium: GoogleFonts.kanit(fontSize: 20, fontWeight: FontWeight.w500),
    headlineSmall: GoogleFonts.kanit(fontSize: 18, fontWeight: FontWeight.w500),
    titleMedium: GoogleFonts.kanit(fontSize: 16),
    bodyMedium: GoogleFonts.kanit(fontSize: 14),
  ),
  cardTheme: const CardThemeData(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFFFC0CB),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    ),
  ),
);