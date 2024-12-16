import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'dart:convert';

class Transaction {
  final String userId;
  final String productName;
  final double amount;
  final DateTime transactionDate;

  Transaction({
    required this.userId,
    required this.productName,
    required this.amount,
    required this.transactionDate,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      userId: json['userId'],
      productName: json['productName'],
      amount: json['amount'],
      transactionDate: DateTime.parse(json['transactionDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'productName': productName,
      'amount': amount,
      'transactionDate': transactionDate.toIso8601String(),
    };
  }
}

class TransactionReportPage extends StatefulWidget {
  @override
  _TransactionReportPageState createState() => _TransactionReportPageState();
}

class _TransactionReportPageState extends State<TransactionReportPage> {
  final List<Transaction> _allTransactions = [
    // Sample Transactions
    Transaction(
        userId: 'User1',
        productName: 'Laptop',
        amount: 1200.0,
        transactionDate: DateTime(2024, 6, 1)),
    Transaction(
        userId: 'User2',
        productName: 'Phone',
        amount: 800.0,
        transactionDate: DateTime(2024, 6, 1)),
    Transaction(
        userId: 'User3',
        productName: 'Headphones',
        amount: 100.0,
        transactionDate: DateTime(2024, 6, 2)),
  ];

  List<Transaction> _filteredTransactions = [];
  DateTime? _selectedDate;

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _filterTransactionsByDate();
      });
    }
  }

  void _filterTransactionsByDate() {
    if (_selectedDate != null) {
      setState(() {
        _filteredTransactions = _allTransactions
            .where((transaction) =>
        transaction.transactionDate.year == _selectedDate!.year &&
            transaction.transactionDate.month == _selectedDate!.month &&
            transaction.transactionDate.day == _selectedDate!.day)
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transaction Report')),
      body: Column(
        children: [
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _pickDate,
            child: Text('Select Date'),
          ),
          if (_selectedDate != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Transactions on: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            child: _filteredTransactions.isEmpty
                ? Center(child: Text('No transactions found for this date.'))
                : ListView.builder(
              itemCount: _filteredTransactions.length,
              itemBuilder: (context, index) {
                final transaction = _filteredTransactions[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: Icon(Icons.receipt_long),
                    title: Text('Product: ${transaction.productName}'),
                    subtitle: Text(
                        'User: ${transaction.userId} | Amount: \$${transaction.amount.toStringAsFixed(2)}'),
                    trailing: Text(
                        DateFormat('yyyy-MM-dd').format(transaction.transactionDate)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
