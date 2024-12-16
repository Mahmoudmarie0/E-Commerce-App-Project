import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  // Upload image to Firebase
  Future<String?> uploadImage(String path, BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Uploading image...")),
    );
    print("Uploading image...");
    File file = File(path);
    try {
      // Create unique file name based on the current time
      String fileName = DateTime.now().toString();

      // Create a reference to Firebase Storage
      Reference ref = storage.ref().child("images/$fileName");

      // Upload the file
      UploadTask uploadTask = ref.putFile(file);

      // Wait for the upload to complete
      await uploadTask;

      // Get the download URL
      String downloadURL = await ref.getDownloadURL();
      print("Download URL: $downloadURL");
      return downloadURL;
    } catch (e) {
      print("There was an error");
      print(e);
      return null;
    }
  }

  // Delete image from Firebase Storage
  Future<void> deleteImage(String imagePath) async {
    try {
      Reference ref = storage.refFromURL(imagePath);
      await ref.delete();
      print("Image deleted successfully: $imagePath");
    } catch (e) {
      print("Error deleting image: $e");
    }
  }
}
