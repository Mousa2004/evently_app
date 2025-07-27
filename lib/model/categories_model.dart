class CategoriesModel {
  String id;
  String name;
  String imageName;
  String imageIcon;
  CategoriesModel({
    required this.id,
    required this.name,
    required this.imageName,
    required this.imageIcon,
  });
  static List<CategoriesModel> categories = [
    CategoriesModel(
      id: "1",
      name: "Sport",
      imageIcon: "bike",
      imageName: "sport_event",
    ),
    CategoriesModel(
      id: "2",
      name: "Birthday",
      imageIcon: "cake",
      imageName: "birthday_event",
    ),
    CategoriesModel(
      id: "3",
      name: "Meeting",
      imageIcon: "meeting",
      imageName: "meeting_event",
    ),
  ];
}
