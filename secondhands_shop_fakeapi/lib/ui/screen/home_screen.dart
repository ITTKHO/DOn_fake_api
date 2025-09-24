import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ✅ ถูกต้อง: ถอยขึ้น 2 ชั้นจาก ui/screen -> lib/providers
import '../../providers/product_provider.dart';
import '../../providers/cart_provider.dart';

// ใช้อย่างใดอย่างหนึ่ง: package import (ต้องให้ name ใน pubspec.yaml ตรง)
import '../widget/product_card.dart'; 
// หรือถ้าไม่อยากพึ่งชื่อแพ็กเกจ ให้ใช้ relative ก็ได้:
// import '../widgets/product_card.dart';

import 'product_detail_screen.dart';
import 'cart_screen.dart';
const bakeryCategories = <String, String>{
  // mapping ชื่อหมวดที่ FakeStore มี → ชื่อธีมเบเกอรี่
  'jewelery': 'gems',
  "men's clothing": 'men clothes',
  "women's clothing": 'women clothes',
  'electronics': 'electronicsr',
};

class HomeScreen extends StatefulWidget { const HomeScreen({super.key}); @override State<HomeScreen> createState() => _HomeScreenState(); }

class _HomeScreenState extends State<HomeScreen> {
  final _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ProductProvider>().load());
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<ProductProvider>();
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Don second hands'),
        actions: [
          IconButton(icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()))),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              controller: _search,
              onChanged: p.setQuery,
              decoration: InputDecoration(
                hintText: 'ค้นหาของมือ 2...',
                prefixIcon: const Icon(Icons.search),
                isDense: true,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // หมวดหมู่ (รีสกิน)
          SizedBox(
            height: 44,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemCount: bakeryCategories.length + 1,
              itemBuilder: (_, i) {
                final key = i == 0 ? '' : bakeryCategories.keys.elementAt(i - 1);
                final label = i == 0 ? 'ทั้งหมด' : bakeryCategories[key]!;
                final selected = p.category == key;
                return ChoiceChip(
                  label: Text(label),
                  selected: selected,
                  onSelected: (_) => context.read<ProductProvider>().load(category: key),
                );
              },
            ),
          ),
          Expanded(
            child: p.loading
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: .68, crossAxisSpacing: 12, mainAxisSpacing: 12),
                  itemCount: p.items.length,
                  itemBuilder: (_, i) {
                    final prod = p.items[i];
                    return ProductCard(
                      p: prod,
                      onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ProductDetailScreen(id: prod.id))),
                      onAdd: () => cart.add(prod),
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }
}
