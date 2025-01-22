import 'package:drift/drift.dart';
import 'package:ecommerce2/app/database/app_database.dart';
import 'package:ecommerce2/app/features/product/data/model/product_model.dart';

class FavoriteModel {
  final int productId;
  final ProductModel? product;

  FavoriteModel({
    required this.productId,
    this.product,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        productId: json['product_id'],
        product: json['product'],
      );

  Map<String, dynamic> toJson() => {'product_id': productId};

  /// Convert from Drift row
  factory FavoriteModel.fromDrift(TypedResult row, favoritesTable, productsTable) {
    // Access the favorites table data
    final favorite = row.readTable(favoritesTable);

    // Access the products table data (if present)
    final product = row.readTableOrNull(productsTable);
    return FavoriteModel(
      productId: favorite.productId,
      product: product != null ? ProductModel.fromDrift(product) : null,
    );
  }

  /// Convert to Drift Companion
  FavoritesCompanion toDriftCompanion() {
    return FavoritesCompanion(productId: Value(productId));
  }
}
