// FILE: lib/ui/screen/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bakery_app/providers/cart_provider.dart'; // Adjust import

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,##0.00');
    return Scaffold(
      appBar: AppBar(title: const Text('ตะกร้าสินค้า')),
      body: Consumer<CartProvider>(
        builder: (context, provider, child) {
          if (provider.items.isEmpty) {
            return const Center(child: Text('ตะกร้าว่างเปล่า'));
          }
          return ListView.builder(
            itemCount: provider.items.length,
            itemBuilder: (context, index) {
              final item = provider.items[index];
              return ListTile(
                leading: Image.network(item.product.image, width: 50, fit: BoxFit.cover),
                title: Text(item.product.title),
                subtitle: Text('฿ ${formatter.format(item.product.price)} x ${item.quantity}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () => provider.updateQuantity(item.product.id, item.quantity - 1),
                    ),
                    Text('${item.quantity}'),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => provider.updateQuantity(item.product.id, item.quantity + 1),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => provider.remove(item.product.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, provider, child) {
          return BottomAppBar(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'ยอดรวม: ฿ ${formatter.format(provider.total)}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          );
        },
      ),
    );
  }
}