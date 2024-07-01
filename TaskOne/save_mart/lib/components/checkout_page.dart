import 'package:flutter/material.dart';
import '../cart.dart';
import '../models/product.dart';
import 'order_success_page.dart';

class CheckoutPage extends StatefulWidget {
  final Function onNavigateToProducts;

  CheckoutPage({required this.onNavigateToProducts});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  void _placeOrder(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderSuccessPage()),
    ).then((_) {
      setState(() {
        Cart.clearCart();
      });
    });
  }

  void _navigateToProducts() {
    widget.onNavigateToProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Cart.products.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Cart is empty.'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        child: const Text('Add products to cart'),
                        onPressed: _navigateToProducts,
                        style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
            ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: Cart.products.length,
                  itemBuilder: (context, index) {
                    final product = Cart.products[index];
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
                      subtitle: Text(product.description),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_circle),
                        onPressed: () {
                          setState(() {
                            Cart.removeProduct(product);
                          });
                        },
                      ),
                    );
                  },
                ),
        ),
        if (Cart.products.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              child: const Text('Place Order'),
              onPressed: () => _placeOrder(context),
              style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
            ),
            ),
          ),
      ],
    );
  }
}
