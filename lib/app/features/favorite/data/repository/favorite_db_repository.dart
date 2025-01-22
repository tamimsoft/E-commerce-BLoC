import 'package:drift/drift.dart';
import 'package:ecommerce2/app/database/app_database.dart';
import 'package:ecommerce2/app/features/favorite/data/model/favorite_model.dart';
import 'package:flutter/material.dart';

class FavoriteDbRepository {
  final AppDatabase _db;

  FavoriteDbRepository(this._db);

  Future<List<FavoriteModel>> fetchDbFavoriteList() async {
    final query = _db.select(_db.favorites).join([
      leftOuterJoin(_db.products, _db.products.id.equalsExp(_db.favorites.productId)),
    ]);

    final dbData = await query.get();
    if (dbData.isNotEmpty) {
      debugPrint('Favorite List:::${dbData.length}');
      final List<FavoriteModel> cartList =
          dbData.map((row) => FavoriteModel.fromDrift(row, _db.favorites, _db.products)).toList();

      return cartList;
    }
    return [];
  }

  Future<void> save(FavoriteModel favoriteItem) async {
    try {
      final companion = favoriteItem.toDriftCompanion();
      var i = await _db.into(_db.favorites).insertOnConflictUpdate(companion);
      debugPrint('Save favorite item:::$i');
    } catch (e) {
      debugPrint('Error Save favorite item:::\n$e');
    }
  }

  Future<void> remove(int productId) async {
    await (_db.delete(_db.favorites)..where((tbl) => tbl.productId.equals(productId))).go();
  }
  Future<void> clear() async {
    await (_db.delete(_db.favorites)).go();
  }

}
