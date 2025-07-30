import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/model/categories_model.dart';

class EventModel {
  String id;
  String userId;
  CategoriesModel category;
  String title;
  String description;
  DateTime dateTime;
  EventModel({
    this.id = '',
    required this.userId,
    required this.category,
    required this.title,
    required this.description,
    required this.dateTime,
  });

  EventModel.fromjson(Map<String, dynamic> json)
    : this(
        id: json["id"],
        userId: json['userId'],
        category: CategoriesModel.categories.firstWhere(
          (Category) => Category.id == json["categoryId"],
        ),
        title: json["title"],
        description: json["description"],
        dateTime: (json["datatime"] as Timestamp).toDate(),
      );

  Map<String, dynamic> tojson() => {
    "id": id,
    "userId": userId,
    "categoryId": category.id,
    "title": title,
    "description": description,
    "datatime": Timestamp.fromDate(dateTime),
  };
}
