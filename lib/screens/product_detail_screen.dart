import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';

class ProductDetailScreen extends ConsumerWidget {
  final String productId;
  const ProductDetailScreen({required this.productId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productProvider(productId));
    return Scaffold(
      appBar: AppBar(title: const Text('Product Detail')),
      body: productAsync.when(
        data: (product) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(product.imageUrl, height: 200),
              const SizedBox(height: 8),
              Text(product.name, style: Theme.of(context).textTheme.titleLarge),
              Text('\$'+product.price.toStringAsFixed(2)),
              const SizedBox(height: 8),
              Text(product.description),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  ref.read(cartProvider.notifier).add(product);
                },
                child: const Text('Add to Cart'),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: '+e.toString())),
      ),
    );
  }
}
