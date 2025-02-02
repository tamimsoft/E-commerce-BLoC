import 'package:drift/drift.dart';
import 'package:fakestore/app/core/services/database/app_database.dart';

class ProductDetailsModel {
  final int productId;
  final List<String> images;
  final String descriptions;
  final List<String> colors;
  final List<String> sizes;

 
  ProductDetailsModel({
    this.productId = 0,
    this.images = const [],
    this.descriptions = '',
    this.colors = const [],
    this.sizes = const [],
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => ProductDetailsModel(
        productId: json['product_id'],
        images: [json['img1'], json['img2'], json['img3'], json['img4']],
        descriptions: json['des'],
        colors: json['color'].split(','),
        sizes: json['size'].split(','),
      );

  /// Convert from Drift row
  factory ProductDetailsModel.fromDrift(ProductDetail row) {
    return ProductDetailsModel(
      productId: row.productId,
      images: row.imageList,
      descriptions: row.fullDescription,
      colors: row.colorList,
      sizes: row.sizeList,
    );
  }

  /// Convert to Drift Companion
  ProductDetailsCompanion toDriftCompanion() {
    return ProductDetailsCompanion(
      productId: Value(productId),
      imageList: Value(images),
      fullDescription: Value(descriptions),
      colorList: Value(colors),
      sizeList: Value(sizes),
    );
  }
}
