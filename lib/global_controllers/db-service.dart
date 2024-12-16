import 'package:cloud_firestore/cloud_firestore.dart';

class DbService{

  //read categories from database
  Stream<QuerySnapshot> readCategories(){
    return FirebaseFirestore.instance
        .collection("shop_categries")
        .orderBy("priority",descending: true)
        .snapshots();
  }
  //create new category
  Future createCategories({required Map<String,dynamic>data})async{
    await FirebaseFirestore.instance.collection("shop_categries").add(data);
  }
  //update category
  Future updateCategories({required String docId,required Map<String,dynamic>data})async{
    await FirebaseFirestore.instance.collection("shop_categries").doc(docId).update(data);
  }
  //delete category
  Future deleteCategories({required String docId})async{
    await FirebaseFirestore.instance.collection("shop_categries").doc(docId).delete();
  }
}