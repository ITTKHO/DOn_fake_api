// FILE: lib/ui/screen/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final items = cart.items;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ตะกร้าสินค้า'),
        actions: [
          if (items.isNotEmpty)
            IconButton(
              onPressed: cart.clear,
              icon: const Icon(Icons.delete_outline),
              tooltip: 'ล้างตะกร้า',
            ),
        ],
      ),
      body: items.isEmpty
          ? const Center(child: Text('ตะกร้าว่างเปล่า'))
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 120),
              itemCount: items.length,
              itemBuilder: (_, i) {
                final it = items[i];
                return Card(
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(it.product.image, width: 56, height: 56, fit: BoxFit.contain),
                    ),
                    title: Text(it.product.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: Text('${it.product.price.toStringAsFixed(2)} ฿ x ${it.quantity}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () => cart.decrement(it.product.id),
                        ),
                        Text(it.quantity.toString()),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () => cart.increment(it.product.id),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => cart.remove(it.product.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: items.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cs.surface,
                border: Border(top: BorderSide(color: cs.outlineVariant)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'ยอดรวม: ${cart.totalPrice.toStringAsFixed(2)} ฿',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('เดโม: ยังไม่เปิดให้ชำระเงิน')),
                      );
                    },
                    child: const Text('ชำระเงิน'),
                  ),
                ],
              ),
            ),
    );
  }
}
