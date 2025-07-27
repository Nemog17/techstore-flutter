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
    final data = jsonDecode(res.body) as List;
    return data.map((e) => Product.fromJson(e)).toList();
  }

  Future<Product> fetchProduct(String id) async {
    final res = await _client.get(Uri.parse('$productBaseUrl/$id'));
    return Product.fromJson(jsonDecode(res.body));
  }

  Future<bool> pay(double amount) async {
    final res = await _client.post(Uri.parse(paymentBaseUrl), body: {'amount': amount.toString()});
    return res.statusCode == 200;
  }
}

final apiServiceProvider = Provider((ref) => ApiService());
