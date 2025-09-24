import 'package:flutter/foundation.dart';
import '../data/models/product.dart';
import '../data/models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final Map<int, CartItem> _map = {}; // key = product.id
  List<CartItem> get items => _map.values.toList();
  double get total => _map.values.fold(0, (s, e) => s + e.subTotal);

  void add(Product p) {
    _map.update(p.id, (old) => CartItem(product: p, qty: old.qty + 1),
      ifAbsent: () => CartItem(product: p, qty: 1));
    notifyListeners();
  }

  void remove(int productId) { _map.remove(productId); notifyListeners(); }
  void setQty(int productId, int qty) {
    if (!_map.containsKey(productId)) return;
    if (qty <= 0) { _map.remove(productId); }
    else { _map[productId]!.qty = qty; }
    notifyListeners();
  }

  void clear() { _map.clear(); notifyListeners(); }
}
