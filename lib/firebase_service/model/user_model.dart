class UserModel {
  String id;
  String name;
  String email;
  List<String> favouritesEventsIds;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.favouritesEventsIds,
  });

  UserModel.fromjson(Map<String, dynamic> json)
    : this(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        favouritesEventsIds: (json['favouritesEventsIds'] as List)
            .cast<String>(),
      );
  Map<String, dynamic> tojson() => {
    "id": id,
    "name": name,
    "email": email,
    "favouritesEventsIds": favouritesEventsIds,
  };
}
