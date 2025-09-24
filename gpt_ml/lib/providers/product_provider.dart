// FILE: lib/providers/product_provider.dart
import 'package:flutter/foundation.dart';

import '../data/models/product.dart';
import '../data/services/api_service.dart';

/// Display categories (Thai name -> FakeStore category)
/// You can reskin names while mapping to real backend categories.
///
/// Note: FakeStore categories: electronics, jewelery, men's clothing, women's clothing
class CategoryDisplay {
  final String labelTh;
  final String backend;
  const CategoryDisplay(this.labelTh, this.backend);
}

class ProductProvider extends ChangeNotifier {
  final ApiService _api;
  ProductProvider(this._api);

  // Reskinned bakery-like categories mapped to FakeStore
  final List<CategoryDisplay> categories = const [
    CategoryDisplay('ทั้งหมด', ''), // all
    CategoryDisplay('electronics', 'electronics'),
    CategoryDisplay('jewelery', 'jewelery'),
    CategoryDisplay('men', "men's clothing"),
    CategoryDisplay('women', "women's clothing"),
  ];

  List<Product> _all = [];
  List<Product> _filtered = [];
  String _query = '';
  String _currentBackendCategory = '';
  bool _loading = false;
  String? _error;

  List<Product> get products => _filtered;
  bool get loading => _loading;
  String? get error => _error;
  String get currentCategory => _currentBackendCategory;
  String get searchQuery => _query;

  Future<void> load({String backendCategory = ''}) async {
    _loading = true;
    _error = null;
    notifyListeners();
    _currentBackendCategory = backendCategory;
    try {
      _all = await _api.fetchProducts(
        category: backendCategory.isEmpty ? null : backendCategory,
      );
      _applyFilters();
    } catch (e) {
      _error = e.toString();
      _all = [];
      _filtered = [];
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void search(String q) {
    _query = q;
    _applyFilters(notify: true);
  }

  void _applyFilters({bool notify = false}) {
    if (_query.trim().isEmpty) {
      _filtered = List<Product>.from(_all);
    } else {
      final lower = _query.toLowerCase();
      _filtered = _all.where((p) {
        return p.title.toLowerCase().contains(lower) ||
            p.description.toLowerCase().contains(lower);
      }).toList();
    }
    if (notify) notifyListeners();
  }
}
