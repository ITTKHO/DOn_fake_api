// FILE: lib/ui/screen/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bakery_app/providers/product_provider.dart'; // Adjust import
import 'package:bakery_app/ui/screen/cart_screen.dart'; // Adjust import
import 'package:bakery_app/ui/screen/product_detail_screen.dart'; // Adjust import
import 'package:bakery_app/ui/widgets/product_card.dart'; // Adjust import

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  late TabController _tabController;

  final List<String> bakeryCategories = ['เค้ก', 'คุกกี้', 'ขนมปัง', 'ของหวานอื่น ๆ'];
  final Map<String, String> apiCategories = {
    'เค้ก': 'electronics',
    'คุกกี้': 'jewelery',
    'ขนมปัง': "men's clothing",
    'ของหวานอื่น ๆ': "women's clothing",
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: bakeryCategories.length, vsync: this);
    _loadProducts(bakeryCategories[0]);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _loadProducts(bakeryCategories[_tabController.index]);
      }
    });
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  void _loadProducts(String bakeryCategory) {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    provider.loadProducts(category: apiCategories[bakeryCategory]);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'ค้นหาสินค้า...',
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartScreen()),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: bakeryCategories.map((cat) => Tab(text: cat)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: bakeryCategories.map((_) => _buildProductGrid()).toList(),
      ),
    );
  }

  Widget _buildProductGrid() {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        final filtered = provider.search(_searchQuery);
        if (filtered.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final product = filtered[index];
            return ProductCard(
              product: product,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(product: product),
                ),
              ),
            );
          },
        );
      },
    );
  }
}