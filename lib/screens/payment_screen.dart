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
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final success = await ref.read(apiServiceProvider).pay(total);
            if (success) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment successful')));
            }
          },
          child: Text('Pay \$'+total.toStringAsFixed(2)),
        ),
      ),
    );
  }
}
