import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String userName = "John Doe";
  String userEmail = "johndoe@example.com";
  String userPhone = "+123 456 7890";
  double totalAmount = 120.00; // Example total amount, replace with dynamic data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff034078), // Medium Blue
        title: const Text(
          'Checkout',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false, // Removes the back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // User Information
            Text(
              'Shipping Information',
              style: TextStyle(
                fontSize: 20,
                color: const Color(0xff034078), // Medium Blue
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Name: $userName',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Email: $userEmail',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Phone: $userPhone',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),

            // Total Amount
            Text(
              'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 30),

            // Payment Method
            Text(
              'Payment Method',
              style: TextStyle(
                fontSize: 20,
                color: const Color(0xff034078), // Medium Blue
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              hint: const Text("Select Payment Method"),
              onChanged: (String? newValue) {},
              items: <String>['Credit Card', 'PayPal', 'Google Pay', 'Apple Pay']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),

            // Confirm Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle checkout logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff034078), // Medium Blue
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  "Confirm Order",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
