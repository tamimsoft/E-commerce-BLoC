part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartEventLoadProduct extends CartEvent {}

class CartEventIncrementQuantity extends CartEvent {
  final int productId;

  const CartEventIncrementQuantity({
    required this.productId,
  });

  @override
  List<Object> get props => [productId];
}

class CartEventDecrementQuantity extends CartEvent {
  final int productId;

  const CartEventDecrementQuantity({
    required this.productId,
  });

  @override
  List<Object> get props => [productId];
}

class CartEventAddToCart extends CartEvent {
  final int productId;
  final int quantity;
  final String colorName;
  final String sizeName;
  final double price;

  const CartEventAddToCart({
    required this.productId,
    required this.quantity,
    required this.colorName,
    required this.sizeName,
    required this.price,
  });

  @override
  List<Object> get props => [productId, quantity, colorName, sizeName, price];
}

class CartEventRemoveProduct extends CartEvent {
  final int productId;

  const CartEventRemoveProduct({
    required this.productId,
  });

  @override
  List<Object> get props => [productId];
}

