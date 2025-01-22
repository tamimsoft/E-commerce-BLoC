import 'package:drift/drift.dart';

import '../../../../database/app_database.dart';

class ProductModel {
  final int id;
  final String title;
  final String shortDes;
  final double price;
  final double discount;
  final double discountPrice;
  final String image;
  final int stock;
  final double star;
  final String remark;
  final int brandId;
  final int categoryId;

  ProductModel({
    required this.id,
    required this.title,
    required this.shortDes,
    required this.price,
    required this.discount,
    required this.discountPrice,
    required this.image,
    required this.stock,
    required this.star,
    required this.remark,
    required this.brandId,
    required this.categoryId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        title: json['title'],
        shortDes: json['short_des'],
        price: double.parse(json['price']),
        discount: json['discount'].toDouble(),
        discountPrice: double.parse(json['discount_price']),
        image: json['image'],
        stock: json['stock'],
        star: json['star'].toDouble(),
        remark: json['remark'],
        brandId: json['brand_id'],
        categoryId: json['category_id'],
      );

  /// Convert from Drift row
  factory ProductModel.fromDrift(Product row) {
    return ProductModel(
      id: row.id,
      title: row.title,
      shortDes: row.shortDescription,
      price: row.price,
      discount: row.discount,
      discountPrice: row.discountPrice,
      image: row.image,
      stock: row.stock,
      star: row.star,
      remark: row.remark,
      brandId: row.brandId,
      categoryId: row.categoryId,
    );
  }

  /// Convert to Drift Companion
  ProductsCompanion toDriftCompanion() {
    return ProductsCompanion(
      id: Value(id),
      title: Value(title),
      shortDescription: Value(shortDes),
      price: Value(price),
      discount: Value(discount),
      discountPrice: Value(discountPrice),
      image: Value(image),
      stock: Value(stock),
      star: Value(star),
      remark: Value(remark.toLowerCase().trim()),
      brandId: Value(brandId),
      categoryId: Value(categoryId),
    );
  }
}
