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

  /// Parses a product returned from the Fake Store API.
  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'].toString(),
        name: json['title'] ?? json['name'],
        imageUrl: json['image'] ?? json['imageUrl'],
        price: (json['price'] as num).toDouble(),
        description: json['description'] ?? '',
      );
}
