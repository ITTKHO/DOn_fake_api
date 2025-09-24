// FILE: lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bakery_app/core/theme/app_theme.dart'; // Adjust import
import 'package:bakery_app/providers/cart_provider.dart'; // Adjust import
import 'package:bakery_app/providers/product_provider.dart'; // Adjust import
import 'package:bakery_app/ui/screen/login_screen.dart'; // Adjust import

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bakery App',
      theme: appTheme,
      home: const LoginScreen(),
    );
  }
}