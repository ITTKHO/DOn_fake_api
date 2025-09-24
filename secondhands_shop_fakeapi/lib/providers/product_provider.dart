import 'package:flutter/foundation.dart';
import '../data/models/product.dart';
import '../data/services/api_service.dart';

class ProductProvider extends ChangeNotifier {
  final _api = ApiService();
  bool loading = false;
  List<Product> _all = [];
  String _category = '';
  String _query = '';

  List<Product> get items {
    var list = _all;
    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      list = list.where((p) =>
        p.title.toLowerCase().contains(q) ||
        p.description.toLowerCase().contains(q)).toList();
    }
    return list;
  }

  String get category => _category;

  Future<void> load({String category = ''}) async {
    loading = true; notifyListeners();
    _category = category;
    _all = await _api.fetchProducts(category: category.isEmpty ? null : category);
    loading = false; notifyListeners();
  }

  void setQuery(String q) { _query = q; notifyListeners(); }
}
