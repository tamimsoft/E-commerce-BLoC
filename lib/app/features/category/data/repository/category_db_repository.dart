import 'package:flutter/material.dart';

import '../../../../database/app_database.dart';
import '../model/category_model.dart';

class CategoryDbRepository {
  final AppDatabase _db;

  CategoryDbRepository(this._db);

  Future<List<CategoryModel>> fetchDbCategories() async {
    final query = _db.select(_db.categories);
    final dbCategories = await query.get();
    if (dbCategories.isNotEmpty) {
      return dbCategories.map((row) => CategoryModel.fromDrift(row)).toList();
    }
    return [];
  }

  Future<void> save(CategoryModel category) async {
    try {
      final categoryCompanion = category.toDriftCompanion();
      var i = await _db.into(_db.categories).insertOnConflictUpdate(categoryCompanion);
      debugPrint('Save category:::$i');
    } catch (e) {
      debugPrint('Error Save category:::\n$e');
    }
  }

  Future<void> deleteAll() async {
    await (_db.delete(_db.categories)).go();
  }
}
