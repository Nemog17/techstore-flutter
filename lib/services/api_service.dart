import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiService {
  final http.Client _client = http.Client();
  // Base URL for products from the Fake Store API
  final String productBaseUrl = 'https://fakestoreapi.com/products';
  // Stripe payment endpoint
  final String paymentBaseUrl = 'https://api.stripe.com/v1/payment_intents';

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

  /// Creates a payment intent using the Stripe API.
  ///
  /// The compile time variable `STRIPE_SECRET_KEY` should contain your
  /// Stripe secret key for authenticating requests.
  Future<bool> pay(double amount) async {
    const secretKey = String.fromEnvironment('STRIPE_SECRET_KEY');
    if (secretKey.isEmpty) {
      throw Exception('Stripe secret key not configured');
    }
    final response = await _client.post(
      Uri.parse(paymentBaseUrl),
      headers: {
        'Authorization': 'Bearer ' + secretKey,
      },
      body: {
        'amount': (amount * 100).toInt().toString(),
        'currency': 'usd',
        'payment_method_types[]': 'card',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to initiate payment: ' + response.statusCode.toString());
    }
    return true;
  }
}

final apiServiceProvider = Provider((ref) => ApiService());
