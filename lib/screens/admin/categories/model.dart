import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
   String id;
   String name;
   DateTime createdAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory CategoryModel.fromDocument(Map<String, dynamic> data, String documentId) {
    return CategoryModel(
      id: documentId,
      name: data['name'] ?? '',
      createdAt: (data['created_at'] as Timestamp).toDate(),
    );
  }
}