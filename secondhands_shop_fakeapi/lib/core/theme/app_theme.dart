import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData bakeryTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 114, 160, 59)),
    scaffoldBackgroundColor: const Color.fromARGB(255, 235, 7, 83),
    cardTheme: CardThemeData(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
}
