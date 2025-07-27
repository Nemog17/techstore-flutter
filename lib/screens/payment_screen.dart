import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';
import '../services/api_service.dart';

class PaymentScreen extends ConsumerWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final total = cart.fold<double>(0, (s, p) => s + p.price);
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (_, i) {
                  final item = cart[i];
                  return ListTile(
                    leading: Image.network(item.imageUrl),
                    title: Text(item.name),
                    trailing: Text('\$' + item.price.toStringAsFixed(2)),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final success = await ref.read(apiServiceProvider).pay(total);
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Payment successful')),
                    );
                    ref.read(cartProvider.notifier).clear();
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  }
                },
                child: Text('Pay \$' + total.toStringAsFixed(2)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
