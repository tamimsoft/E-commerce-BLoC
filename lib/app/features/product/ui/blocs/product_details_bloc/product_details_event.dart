part of 'product_details_bloc.dart';

sealed class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();

  @override
  List<Object> get props => [];
}

class ProductDetailsEventLoad extends ProductDetailsEvent {
  final int productId;

  const ProductDetailsEventLoad({required this.productId});

  @override
  List<Object> get props => [productId];
}

class ProductDetailsEventSelectColor extends ProductDetailsEvent {
  final String selectedColor;

  const ProductDetailsEventSelectColor({required this.selectedColor});

  @override
  List<Object> get props => [selectedColor];
}

class ProductDetailsEventSelectSize extends ProductDetailsEvent {
  final String selectedSize;

  const ProductDetailsEventSelectSize({required this.selectedSize});

  @override
  List<Object> get props => [selectedSize];
}
