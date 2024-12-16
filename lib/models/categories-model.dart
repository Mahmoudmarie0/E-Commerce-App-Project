import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesModel{
  String name;
  String image;
  String id;
  int priority;

  CategoriesModel({
    required this.id,
    required this.name,
    required this.image,
    required this.priority,
  });

  //convert from json to object model
    factory CategoriesModel.fromJson(Map<String,dynamic>json,String id){
      return CategoriesModel(
        name: json["name"]??"",
        image: json["image"]??"",
        priority: json["priority"]??"",
        id: id??"",
      );
    }
//convert List<QueryDocumentSnapshot> to List<CategoriesModel>
static List<CategoriesModel> fromJsonList(List<QueryDocumentSnapshot>list){
      return list.map((e) => CategoriesModel.fromJson(e.data() as Map<String,dynamic>,e.id)).toList();
}

}