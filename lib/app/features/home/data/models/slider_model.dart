import 'package:drift/drift.dart';

import '../../../../database/app_database.dart';

class SliderModel {
  final int id;
  final String title;
  final String shortDescription;
  final String price;
  final String image;
  final int productId;

  SliderModel({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.price,
    required this.image,
    required this.productId,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        id: json['id'],
        title: json['title'],
        shortDescription: json['short_des'],
        price: json['price'],
        image: json['image'],
        productId: json['product_id'],
      );

  /// Convert from Drift row
  factory SliderModel.fromDrift(Slider row) {
    return SliderModel(
      id: row.id,
      title: row.title,
      shortDescription: row.shortDescription,
      price: row.price,
      image: row.image,
      productId: row.productId,
    );
  }

  /// Convert to Drift Companion
  SlidersCompanion toDriftCompanion() {
    return SlidersCompanion(
      id: Value(id),
      title: Value(title),
      shortDescription: Value(shortDescription),
      price: Value(price),
      image: Value(image),
      productId: Value(productId),
    );
  }
}
