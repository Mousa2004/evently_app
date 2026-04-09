import 'package:evently_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

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
  static List<CategoriesModel> categories(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return [
      CategoriesModel(
        id: "1",
        name: appLocalizations.sport,
        imageIcon: "bike",
        imageName: "sport_event",
      ),
      CategoriesModel(
        id: "2",
        name: appLocalizations.birthday,
        imageIcon: "cake",
        imageName: "birthday_event",
      ),
      CategoriesModel(
        id: "3",
        name: appLocalizations.meeting,
        imageIcon: "meeting",
        imageName: "meeting_event",
      ),
    ];
  }
}
