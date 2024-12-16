import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceproject/global_controllers/db-service.dart';
import 'package:flutter/cupertino.dart';

class AdminProvider extends ChangeNotifier{
  List<QueryDocumentSnapshot>categories=[];
  StreamSubscription<QuerySnapshot>? categorySubscription;

  int totalCategories=0;
  AdminProvider(){
    getCategories();
  }

  //Get all the categories
  void getCategories() {
    categorySubscription?.cancel();
    categorySubscription = DbService().readCategories().listen(
          (snapshot) {
        categories = snapshot.docs;
        totalCategories = snapshot.docs.length;
        notifyListeners();
      },
      onError: (error) {
        print("Error reading categories: $error");
      },
    );
  }

}