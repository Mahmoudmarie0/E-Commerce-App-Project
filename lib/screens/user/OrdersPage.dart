import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders Page"),
        automaticallyImplyLeading: false, // This removes the back button
      ),
      body: ListView.builder(
        itemCount: 10, // This is a placeholder, replace with dynamic data
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: Text('Order #${index + 1}'),
            subtitle: const Text('Status: Pending'),
            onTap: () {
              // You can later replace this with actual order details page navigation
            },
          );
        },
      ),
    );
  }
}
