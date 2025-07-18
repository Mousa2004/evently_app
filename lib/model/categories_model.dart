class CategoriesModel {
  String id;
  String name;
  String imageName;
  CategoriesModel({
    required this.id,
    required this.name,
    required this.imageName,
  });
  static List<CategoriesModel> categories = [
    CategoriesModel(id: "1", name: "Sport", imageName: "bike"),
    CategoriesModel(id: "2", name: "Birthday", imageName: "cake"),
    CategoriesModel(id: "3", name: "Sport", imageName: "bike"),
    CategoriesModel(id: "4", name: "Birthday", imageName: "cake"),
  ];
}
