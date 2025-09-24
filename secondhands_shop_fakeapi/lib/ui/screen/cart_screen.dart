import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Basket')),
      body: cart.items.isEmpty
        ? const Center(child: Text('Empty cart'))
        : ListView.separated(
            padding: const EdgeInsets.all(12),
            itemBuilder: (_, i) {
              final it = cart.items[i];
              return Card(
                child: ListTile(
                  leading: Image.network(it.product.image, width: 56, fit: BoxFit.contain),
                  title: Text(it.product.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                  subtitle: Text('ชิ้นละ ${it.product.price.toStringAsFixed(2)} • ยอดย่อย ${it.subTotal.toStringAsFixed(2)}'),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    IconButton(icon: const Icon(Icons.remove), onPressed: () => cart.setQty(it.product.id, it.qty - 1)),
                    Text('${it.qty}'),
                    IconButton(icon: const Icon(Icons.add), onPressed: () => cart.setQty(it.product.id, it.qty + 1)),
                  ]),
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemCount: cart.items.length,
          ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(child: Text('รวมทั้งหมด: ${cart.total.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              FilledButton(onPressed: cart.items.isEmpty ? null : () {}, child: const Text('ชำระเงิน')),
            ],
          ),
        ),
      ),
    );
  }
}
