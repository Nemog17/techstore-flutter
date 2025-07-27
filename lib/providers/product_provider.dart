import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductListNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  final ApiService api;
  ProductListNotifier(this.api) : super(const AsyncValue.loading()) {
    load();
  }

  Future<void> load() async {
    try {
      final items = await api.fetchProducts();
      state = AsyncValue.data(items);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void remove(String id) {
    if (state case AsyncData(:final value)) {
      state = AsyncValue.data(value.where((p) => p.id != id).toList());
    }
  }
}

final productListProvider = StateNotifierProvider<ProductListNotifier, AsyncValue<List<Product>>>((ref) {
  final api = ref.read(apiServiceProvider);
  return ProductListNotifier(api);
});

final productProvider = FutureProvider.family<Product, String>((ref, id) async {
  final api = ref.read(apiServiceProvider);
  return api.fetchProduct(id);
});
