class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
  });

  /// Parses a product returned from the API. Supports both Fake Store and
  /// DummyJSON formats.
  factory Product.fromJson(Map<String, dynamic> json) {
    String image = '';
    if (json['image'] != null) {
      image = json['image'];
    } else if (json['thumbnail'] != null) {
      image = json['thumbnail'];
    } else if (json['images'] is List && (json['images'] as List).isNotEmpty) {
      image = json['images'][0];
    }

    return Product(
      id: json['id'].toString(),
      name: json['title'] ?? json['name'],
      imageUrl: image,
      price: (json['price'] as num).toDouble(),
      description: json['description'] ?? '',
    );
  }
}
