import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';

class CartNotifier extends StateNotifier<List<Product>> {
  CartNotifier() : super([]);

  void add(Product product) {
    state = [...state, product];
  }

  void clear() {
    state = [];
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<Product>>((ref) => CartNotifier());
