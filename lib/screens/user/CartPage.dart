import 'package:flutter/material.dart';
import 'package:ecommerceproject/screens/user/checkout.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart Page"),
        automaticallyImplyLeading: false, // This removes the back button
      ),
      body: ListView.builder(
        itemCount: 5, // Example number of items in the cart, replace with dynamic data
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: Text('Item #${index + 1}'),
            subtitle: const Text('Price: \$20.00'),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: () {
                // Handle item removal logic here
              },
            ),
            onTap: () {
              // Handle item tap to view details (if needed)
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the CheckoutPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CheckoutPage()),
            );
          },
          child: const Text("Proceed to Checkout"),
        ),
      ),
    );
  }
}
