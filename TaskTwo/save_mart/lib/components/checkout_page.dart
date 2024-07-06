import 'package:flutter/material.dart';
import '../cart.dart';
import 'order_success_page.dart';

class CheckoutPage extends StatefulWidget {
  final VoidCallback onNavigateToProducts;

  const CheckoutPage({Key? key, required this.onNavigateToProducts}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Cart.products.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Cart is empty.'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: widget.onNavigateToProducts,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Add products to cart'),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: Cart.products.length,
                    itemBuilder: (context, index) {
                      final product = Cart.products[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12.0),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                product.imageUrl,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/noImage.png',
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  );
                                },
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
                          ),
                        ),
                      );
                    },
                  ),
          ),
          if (Cart.products.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () => _placeOrder(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Place Order'),
              ),
            ),
        ],
      ),
    );
  }
}
