import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final total = cart.fold<double>(0, (sum, item) => sum + item.price);

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (_, i) {
          final item = cart[i];
          return ListTile(
            leading: Image.network(item.imageUrl),
            title: Text(item.name),
            trailing: Text('\$'+item.price.toStringAsFixed(2)),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/payment'),
          child: Text('Checkout (\$'+total.toStringAsFixed(2)+')'),
        ),
      ),
    );
  }
}
