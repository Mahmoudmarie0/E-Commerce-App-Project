import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecommerceproject/models/cart_model.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  // Sample categories and products
  List<String> categories = ["All", "Electronics", "Fashion", "Home", "Books"];
  String? selectedCategory; // To store the selected category
  List<Map<String, String>> products = [
    {"name": "Laptop", "price": "1000", "image": "https://via.placeholder.com/150", "category": "Electronics"},
    {"name": "Shirt", "price": "30", "image": "https://via.placeholder.com/150", "category": "Fashion"},
    {"name": "Sofa", "price": "500", "image": "https://via.placeholder.com/150", "category": "Home"},
    {"name": "Book", "price": "15", "image": "https://via.placeholder.com/150", "category": "Books"},
  ];

  List<CartItem> cart = []; // Cart to hold selected products

  // Filter products based on selected category
  List<Map<String, String>> get filteredProducts {
    if (selectedCategory == null || selectedCategory == "All") return products;
    return products.where((product) => product['category'] == selectedCategory).toList();
  }

  // Add product to cart or update quantity if it already exists
  void addToCart(Map<String, String> product) {
    setState(() {
      final existingProduct = cart.firstWhere(
            (item) => item.name == product['name'],
        orElse: () => CartItem(name: "", price: "", image: ""),
      );

      if (existingProduct.name.isNotEmpty) {
        existingProduct.quantity++;
      } else {
        cart.add(CartItem(
          name: product['name']!,
          price: product['price']!,
          image: product['image']!,
        ));
      }
    });
  }

  // Remove product from the cart
  void removeFromCart(CartItem product) {
    setState(() {
      cart.remove(product);
    });
  }

  // Update product quantity in the cart
  void updateCartItemQuantity(CartItem product, int quantity) {
    setState(() {
      product.quantity = quantity;
    });
  }

  // Calculate the total cost of the items in the cart
  double getOrderTotal() {
    double total = 0.0;
    for (var item in cart) {
      total += (double.tryParse(item.price) ?? 0) * item.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Navigation (Dropdown)
              Text(
                "Categories",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              DropdownButton<String>(
                value: selectedCategory,
                hint: const Text("Select a category"),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                },
                items: categories.map<DropdownMenuItem<String>>((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              ),
              SizedBox(height: 20.h),

              // Product List
              Text(
                "Products",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              Column(
                children: List.generate(filteredProducts.length, (index) {
                  var product = filteredProducts[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          product["image"]!,
                          width: 100.w,
                          height: 100.h,
                          fit: BoxFit.cover,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product["name"]!,
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            Text(
                              "\$${product["price"]}",
                              style: TextStyle(fontSize: 14.sp, color: Colors.green),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () => addToCart(product),
                          child: const Text('Add to Cart'),
                        ),
                      ],
                    ),
                  );
                }),
              ),

              // Cart Section
              Text(
                "Cart",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final cartItem = cart[index];
                  return ListTile(
                    leading: Image.network(cartItem.image, width: 50.w, height: 50.h),
                    title: Text(cartItem.name),
                    subtitle: Row(
                      children: [
                        Text("\$${cartItem.price}"),
                        SizedBox(width: 20.w),
                        Text("x${cartItem.quantity}"),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            if (cartItem.quantity > 1) {
                              updateCartItemQuantity(cartItem, cartItem.quantity - 1);
                            } else {
                              removeFromCart(cartItem);
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            updateCartItemQuantity(cartItem, cartItem.quantity + 1);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),

              // Order Total
              SizedBox(height: 20.h),
              Text(
                "Order Total: \$${getOrderTotal().toStringAsFixed(2)}",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
