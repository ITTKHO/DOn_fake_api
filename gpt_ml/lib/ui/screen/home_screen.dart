// FILE: lib/ui/screen/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';
import '../../providers/cart_provider.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchCtl = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final p = context.read<ProductProvider>();
      p.load(); // load all at start
    });
  }

  @override
  void dispose() {
    _searchCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProv = context.watch<ProductProvider>();
    final cartProv = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Don Second Hands'),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                ),
              ),
              if (cartProv.totalItems > 0)
                Positioned(
                  right: 8,
                  top: 10,
                  child: CircleAvatar(
                    radius: 10,
                    child: Text(
                      cartProv.totalItems.toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
              child: TextField(
                controller: _searchCtl,
                onChanged: productProv.search,
                decoration: const InputDecoration(
                  hintText: 'ค้นหาสินค้า (ชื่อ/รายละเอียด)...',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            // Category chips
            SizedBox(
              height: 48,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, i) {
                  final c = productProv.categories[i];
                  final selected = productProv.currentCategory == c.backend || (c.backend.isEmpty && productProv.currentCategory.isEmpty);
                  return ChoiceChip(
                    label: Text(c.labelTh),
                    selected: selected,
                    onSelected: (_) => productProv.load(backendCategory: c.backend),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemCount: productProv.categories.length,
              ),
            ),
            const SizedBox(height: 8),
            // Grid
            Expanded(
              child: Builder(
                builder: (_) {
                  if (productProv.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (productProv.error != null) {
                    return Center(child: Text('เกิดข้อผิดพลาด: ${productProv.error}'));
                  }
                  final items = productProv.products;
                  if (items.isEmpty) {
                    return const Center(child: Text('ไม่พบสินค้า'));
                  }
                  final cross = MediaQuery.of(context).size.width > 720 ? 4 : 2;
                  return GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: cross,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: .68,
                    ),
                    itemCount: items.length,
                    itemBuilder: (_, i) => ProductCard(product: items[i]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
