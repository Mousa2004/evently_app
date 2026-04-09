import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String id;
  String userId;
  String categoryId;
  String title;
  String description;
  DateTime dateTime;

  EventModel({
    this.id = '',
    required this.userId,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.dateTime,
  });

  EventModel.fromjson(Map<String, dynamic> json)
    : this(
        id: json["id"],
        userId: json['userId'],
        categoryId: json["categoryId"], // 👈 هنا
        title: json["title"],
        description: json["description"],
        dateTime: (json["datatime"] as Timestamp).toDate(),
      );

  Map<String, dynamic> tojson() => {
    "id": id,
    "userId": userId,
    "categoryId": categoryId,
    "title": title,
    "description": description,
    "datatime": Timestamp.fromDate(dateTime),
  };
}
