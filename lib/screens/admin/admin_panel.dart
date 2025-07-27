import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/product_provider.dart';

class AdminPanel extends ConsumerWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productListProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Panel')),
      body: products.when(
        data: (items) => ListView.builder(
          itemCount: items.length,
          itemBuilder: (_, i) {
            final p = items[i];
            return ListTile(
              title: Text(p.name),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  ref.read(productListProvider.notifier).remove(p.id);
                },
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: '+e.toString())),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: add product creation flow
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
