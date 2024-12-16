class OrderFeedback {
  final String orderId;
  final String feedback;
  final int rating; // 1-5 stars

  OrderFeedback({
    required this.orderId,
    required this.feedback,
    required this.rating,
  });

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'feedback': feedback,
      'rating': rating,
    };
  }

  factory OrderFeedback.fromJson(Map<String, dynamic> json) {
    return OrderFeedback(
      orderId: json['orderId'],
      feedback: json['feedback'],
      rating: json['rating'],
    );
  }
}
