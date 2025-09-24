import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/services/api_service.dart';
import '../../../data/models/product.dart';
import '../../../providers/cart_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final int id;
  const ProductDetailScreen({super.key, required this.id});
  @override State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final _api = ApiService();
  Product? product; bool loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    product = await _api.fetchProduct(widget.id);
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    if (loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    final p = product!;
    return Scaffold(
      appBar: AppBar(title: Text(p.title, maxLines: 1, overflow: TextOverflow.ellipsis)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AspectRatio(aspectRatio: 1.3, child: Image.network(p.image, fit: BoxFit.contain)),
          const SizedBox(height: 12),
          Text(p.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Row(children: [const Icon(Icons.star, size: 18), const SizedBox(width: 6),
            Text('${p.rating} (${p.ratingCount} รีวิว)')]),
          const SizedBox(height: 8),
          Text('รายละเอียด', style: Theme.of(context).textTheme.titleMedium),
          Text(p.description),
          const SizedBox(height: 12),
          Text('ราคา ${p.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: FilledButton.icon(
            onPressed: () => cart.add(p),
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('เพิ่มลงตะกร้า'),
          ),
        ),
      ),
    );
  }
}
