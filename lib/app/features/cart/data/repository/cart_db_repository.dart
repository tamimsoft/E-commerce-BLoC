import 'package:drift/drift.dart';
import 'package:ecommerce2/app/database/app_database.dart';
import 'package:ecommerce2/app/features/cart/data/model/cart_model.dart';
import 'package:flutter/material.dart';

class CartDbRepository {
  final AppDatabase _db;

  CartDbRepository(this._db);

  Future<List<CartModel>> fetchDbCartList() async {
    final query = _db.select(_db.carts).join([
      leftOuterJoin(_db.products, _db.products.id.equalsExp(_db.carts.productId)),
    ]);

    final dbData = await query.get();
    if (dbData.isNotEmpty) {
      debugPrint('Cart List:::${dbData.length}');
      final List<CartModel> cartList = dbData.map((row) => CartModel.fromDrift(row, _db.carts, _db.products)).toList();

      return cartList;
    }
    return [];
  }

  Future<void> save({required CartModel cart}) async {
    try {
      final companion = cart.toDriftCompanion();
      var i = await _db.into(_db.carts).insertOnConflictUpdate(companion);
      debugPrint('Save Cart:::$i');
    } catch (e) {
      debugPrint('Error Save Cart:::\n$e');
    }
  }

  Future<void> remove({required int productId}) async {
    await (_db.delete(_db.carts)..where((tbl) => tbl.productId.equals(productId))).go();
  }

  Future<void> clear() async {
    await _db.delete(_db.carts).go();
  }
}
