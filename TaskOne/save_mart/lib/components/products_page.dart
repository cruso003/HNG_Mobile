import 'package:flutter/material.dart';
import '../cart.dart';
import '../models/product.dart';

class ProductsPage extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: 'Jordan',
      price: 150.0,
      imageUrl: 'assets/images/product1.webp',
      description: 'Lorem ipsum dolor sit amet',
    ),
    Product(
      name: 'Nike',
      price: 100.0,
      imageUrl: 'assets/images/product2.webp',
      description: 'Sed do eiusmod .',
    ),
    Product(
      name: 'Air Nike',
      price: 200.0,
      imageUrl: 'assets/images/product3.webp',
      description: 'Ut enim ad.',
    ),
  ];

  void _showAlert(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              product.imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(product.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('\$${product.price}'),
              Text(product.description),
            ],
          ),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
            ),
            child: const Text('Add to Cart'),
            onPressed: () {
              Cart.addProduct(product);
              _showAlert(context, '${product.name} added to cart');
            },
          ),
        );
      },
    );
  }
}
