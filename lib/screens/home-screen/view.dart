// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:ecommerceproject/screens/user/user-home/view.dart';
import 'package:ecommerceproject/screens/user/profile.dart';
import 'package:ecommerceproject/screens/user/CartPage.dart';
import 'package:ecommerceproject/screens/user/OrdersPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of pages for each navigation tab
  final List<Widget> _pages =  [
    UserHomeScreen(), // Home page
    OrdersPage(),
    CartPage(),
    ProfilePage(),
  ];

  // Method to handle tab changes
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff034078), // mediumBlue color
        title: const Text(
          "E-Commerce",
          style: TextStyle(
            color: Color(0xff034078), // mediumBlue
            fontSize: 20,
          ),
        ),
      ),
      body: _pages[_selectedIndex], // Show the selected page
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff0A1128), // darkBlue background
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xff1282A2), // lightBlue for selected item
        unselectedItemColor: const Color(0xff1282A2), // lightBlue for unselected item (same color)
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
