import 'package:drift/drift.dart';
import 'package:ecommerce2/app/database/app_database.dart';
import 'package:ecommerce2/app/features/product/data/model/product_model.dart';

class CartModel {
  final int productId;
  final String colorName;
  final String sizeName;
  final int quantity;
  final String price;

  final ProductModel? product;

  CartModel({
    required this.productId,
    required this.colorName,
    required this.sizeName,
    required this.quantity,
    required this.price,
    this.product,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        productId: json['product_id'],
        colorName: json['color'],
        sizeName: json['size'],
        quantity: json['qty'],
        price: json['price'],
        product: json['product'],
      );

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'color': colorName,
        'size': sizeName,
        'qty': quantity,
        'price': price,
      };

  /// Convert from Drift row
  factory CartModel.fromDrift(TypedResult row, cartsTable, productsTable) {
    // Access the carts table data
    final cart = row.readTable(cartsTable);

    // Access the products table data (if present)
    final product = row.readTableOrNull(productsTable);
    return CartModel(
      productId: cart.productId,
      colorName: cart.colorName,
      sizeName: cart.sizeName,
      quantity: cart.quantity,
      price: cart.price,
      product: product != null ? ProductModel.fromDrift(product) : null,
    );
  }

  /// Convert to Drift Companion
  CartsCompanion toDriftCompanion() {
    return CartsCompanion(
      productId: Value(productId),
      colorName: Value(colorName),
      sizeName: Value(sizeName),
      quantity: Value(quantity),
      price: Value(price),
    );
  }
}
