import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'providers/product_provider.dart';
import 'providers/cart_provider.dart';
import 'ui/screen/login_screen.dart'; // ⬅ import login

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ProductProvider()),
      ChangeNotifierProvider(create: (_) => CartProvider()),
    ],
    child: const BakeryApp(),
  ));
}

class BakeryApp extends StatelessWidget {
  const BakeryApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Don Bakery',
      debugShowCheckedModeBanner: false,
      theme: bakeryTheme(),
      home: const LoginScreen(), // ⬅ เริ่มจาก login
    );
  }
}
