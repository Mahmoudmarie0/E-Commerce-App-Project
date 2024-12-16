import 'package:ecommerceproject/models/feedback-model.dart';
import 'package:flutter/material.dart';

class AdminFeedbackPage extends StatelessWidget {
  // Sample feedback data (replace with database or API data)
  final List<OrderFeedback> feedbackList = [
    OrderFeedback(orderId: 'Order123', feedback: 'Great service!', rating: 5),
    OrderFeedback(orderId: 'Order124', feedback: 'Good product quality', rating: 4),
    OrderFeedback(orderId: 'Order125', feedback: 'Late delivery', rating: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Customer Feedback')),
      body: ListView.builder(
        itemCount: feedbackList.length,
        itemBuilder: (context, index) {
          final feedback = feedbackList[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: Icon(Icons.star, color: Colors.amber),
              title: Text('Order ID: ${feedback.orderId}'),
              subtitle: Text('Feedback: ${feedback.feedback}'),
              trailing: Text(
                '${feedback.rating} ★',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
