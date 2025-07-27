import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List<Product>> _loadProducts() {
    final api = ApiService();
    return api.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'icon': Icons.apps, 'label': 'All'},
      {'icon': Icons.laptop, 'label': 'Laptops'},
      {'icon': Icons.screenshot_monitor, 'label': 'GPUs'},
      {'icon': Icons.memory, 'label': 'CPUs'},
      {'icon': Icons.sd_storage, 'label': 'Storage'},
      {'icon': Icons.storage, 'label': 'RAM'},
      {'icon': Icons.headphones, 'label': 'Accessories'},
    ];

    Widget buildCategory(Map<String, dynamic> c) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.deepPurple.shade100,
              child: Icon(c['icon'] as IconData, color: Colors.deepPurple),
            ),
            const SizedBox(height: 4),
            Text(c['label'] as String, style: const TextStyle(fontSize: 12)),
          ],
        ),
      );
    }

    Widget buildProduct(Product p) {
      return Card(
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      p.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                p.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('\$${p.price.toStringAsFixed(2)}'),
            ),
            const SizedBox(height: 8),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('TechStore'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: categories.map(buildCategory).toList(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: _loadProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  final products = snapshot.data ?? [];
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: products.length,
                    itemBuilder: (_, i) => buildProduct(products[i]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
