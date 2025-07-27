import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiService {
  final http.Client _client = http.Client();
  final String productBaseUrl = 'https://example.com/api/products';
  final String paymentBaseUrl = 'https://example.com/api/pay';

  Future<List<Product>> fetchProducts() async {
    final res = await _client.get(Uri.parse(productBaseUrl));
    if (res.statusCode != 200) {
      throw Exception('Failed to fetch products: ${res.statusCode}');
    }
    final data = jsonDecode(res.body);
    if (data is! List) {
      throw const FormatException('Unexpected response format');
    }
    return data.map((e) => Product.fromJson(e)).toList();
  }

  Future<Product> fetchProduct(String id) async {
    final res = await _client.get(Uri.parse('$productBaseUrl/$id'));
    if (res.statusCode != 200) {
      throw Exception('Failed to fetch product: ${res.statusCode}');
    }
    final data = jsonDecode(res.body);
    if (data is! Map<String, dynamic>) {
      throw const FormatException('Unexpected response format');
    }
    return Product.fromJson(data);
  }

  Future<bool> pay(double amount) async {
    final res = await _client
        .post(Uri.parse(paymentBaseUrl), body: {'amount': amount.toString()});
    return res.statusCode == 200;
  }
}

final apiServiceProvider = Provider((ref) => ApiService());
