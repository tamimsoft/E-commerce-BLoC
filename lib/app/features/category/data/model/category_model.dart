import 'package:drift/drift.dart';

import 'package:fakestore/app/core/services/database/app_database.dart';

class CategoryModel {
  final int id;
  final String name;
  final String image;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'],
        name: json['categoryName'],
        image: json['categoryImg'],
      );

  /// Convert from Drift row
  factory CategoryModel.fromDrift(Category row) {
    return CategoryModel(
      id: row.id,
      name: row.name,
      image: row.image,
    );
  }

  /// Convert to Drift Companion
  CategoriesCompanion toDriftCompanion() {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      image: Value(image),
    );
  }
}
