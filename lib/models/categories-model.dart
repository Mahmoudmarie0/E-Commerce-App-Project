import 'dart:convert';

class Category {
  String name;

  Category({
    required this.name,
  });

  // Convert Category to Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  // Convert Map to Category
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name'],
    );
  }

  // Convert Category to JSON
  String toJson() => json.encode(toMap());

  // Create a Category from JSON
  factory Category.fromJson(String jsonString) {
    return Category.fromMap(json.decode(jsonString));
  }
}
