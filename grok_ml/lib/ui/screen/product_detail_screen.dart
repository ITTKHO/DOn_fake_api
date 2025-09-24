// FILE: lib/ui/screen/product_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bakery_app/data/models/product.dart'; // Adjust import
import 'package:bakery_app/providers/cart_provider.dart'; // Adjust import

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,##0.00');
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.image, height: 300, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(product.title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text('Rating: ${product.ratingRate} (${product.ratingCount} reviews)'),
            const SizedBox(height: 8),
            Text(product.description),
            const SizedBox(height: 16),
            Text('฿ ${formatter.format(product.price)}', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false).add(product);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('เพิ่มลงตะกร้าแล้ว')));
              },
              child: const Text('เพิ่มลงตะกร้า'),
            ),
          ],
        ),
      ),
    );
  }
}