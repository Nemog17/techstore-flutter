import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('TechStore')),
      body: products.when(
        data: (items) => GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemCount: items.length,
          itemBuilder: (_, i) {
            final p = items[i];
            return Card(
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/product/'+p.id),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Image.network(p.imageUrl, fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(p.name),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('\$'+p.price.toStringAsFixed(2)),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: '+e.toString())),
      ),
    );
  }
}
