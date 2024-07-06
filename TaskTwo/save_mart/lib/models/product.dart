class Product {
  final String name;
  final double price;
  final String imageUrl;
  final String description;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    String imageUrl;
    if (json['photos'] != null && json['photos'].isNotEmpty) {
      imageUrl = 'https://api.timbu.cloud/images/${json['photos'][0]['url']}';
    } else {
      imageUrl = 'https://www.smilemerchant.com/images/products/noImageProduct.jpg';
    }

    return Product(
      name: json['name'],
      price: json['current_price'] != null && json['current_price'].isNotEmpty
          ? json['current_price'][0]['USD'][0]?.toDouble() ?? 0.0
          : 0.0,
      imageUrl: imageUrl,
      description: json['description'],
    );
  }
}
