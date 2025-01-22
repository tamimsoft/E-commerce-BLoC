import '/app/features/product/data/model/product_details_model.dart';
import 'package:flutter/material.dart';

import '../../../../database/app_database.dart';
import '../model/product_model.dart';

class ProductDbRepository {
  final AppDatabase _db;

  ProductDbRepository(this._db);

  Future<List<ProductModel>> fetchDbAllProducts() async {
    final query = _db.select(_db.products);

    final dbProducts = await query.get();
    if (dbProducts.isNotEmpty) {
      return dbProducts.map((row) => ProductModel.fromDrift(row)).toList();
    }
    return [];
  }

  Future<List<ProductModel>> fetchDbProductsByRemark({required String remark}) async {
    final query = _db.select(_db.products)..where((tbl) => tbl.remark.equals(remark.toLowerCase().trim()));

    final dbProducts = await query.get();
    if (dbProducts.isNotEmpty) {
      return dbProducts.map((row) => ProductModel.fromDrift(row)).toList();
    }
    return [];
  }

  Future<List<ProductModel>> fetchDbProductsByCategory({required int categoryId}) async {
    final query = _db.select(_db.products)..where((tbl) => tbl.categoryId.equals(categoryId));
    final dbProducts = await query.get();
    if (dbProducts.isNotEmpty) {
      return dbProducts.map((row) => ProductModel.fromDrift(row)).toList();
    }
    return [];
  }

  Future<List<ProductModel>> fetchDbProductsByBrand({required int brandId}) async {
    final query = _db.select(_db.products)..where((tbl) => tbl.brandId.equals(brandId));
    final dbProducts = await query.get();
    if (dbProducts.isNotEmpty) {
      return dbProducts.map((row) => ProductModel.fromDrift(row)).toList();
    }
    return [];
  }

  Future<void> saveProduct({required ProductModel product}) async {
    try {
      final ProductsCompanion productCompanion = product.toDriftCompanion();
      final i = await _db.into(_db.products).insertOnConflictUpdate(productCompanion);
      debugPrint('Save Product:::$i');
    } catch (e) {
      debugPrint('Error Save Products:::\n$e');
    }
  }

  Future<void> removeProduct({required int id}) async {
    await (_db.delete(_db.products)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> clearProducts() async {
    await (_db.delete(_db.products)).go();
  }

  Future<ProductDetailsModel?> fetchProductDetailsById({required int productId}) async {
    final query = _db.select(_db.productDetails)
      ..where((tbl) => tbl.productId.equals(productId))
      ..limit(1);
    final dbProduct = await query.get();
    if (dbProduct.isNotEmpty) {
      return ProductDetailsModel.fromDrift(dbProduct.first);
    }
    return null;
  }

  Future<void> saveProductDetails(ProductDetailsModel product) async {
    try {
      final ProductDetailsCompanion productCompanion = product.toDriftCompanion();
      final i = await _db.into(_db.productDetails).insertOnConflictUpdate(productCompanion);
      debugPrint('Save Product Details:::$i');
    } catch (e) {
      debugPrint('Error Save Product Details:::\n$e');
    }
  }

  Future<void> removeProductDetails({required int id}) async {
    await (_db.delete(_db.productDetails)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> clearProductDetails() async {
    await (_db.delete(_db.productDetails)).go();
  }
}
