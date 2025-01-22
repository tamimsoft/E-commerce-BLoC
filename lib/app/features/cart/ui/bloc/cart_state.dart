part of 'cart_bloc.dart';

enum Status { empty, loading, loaded, error, success }

class CartState extends Equatable {
  final Status status;
  final String errorMsg;
  final List<CartModel> cartList;
  final List<ProductDetailsModel> productDetailsList;
  final Map<int, int> quantities;
  final double checkoutTotal;

  const CartState({
    this.status = Status.empty,
    this.errorMsg = '',
    this.cartList = const [],
    this.productDetailsList = const [],
    this.quantities = const {},
    this.checkoutTotal = 0,
  });

  CartState copyWith({
    Status? status,
    String? errorMsg,
    List<CartModel>? cartList,
    List<ProductDetailsModel>? productDetailsList,
    Map<int, int>? quantities,
    double? checkoutTotal,
  }) {
    return CartState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      cartList: cartList ?? this.cartList,
      productDetailsList: productDetailsList ?? this.productDetailsList,
      quantities: quantities ?? this.quantities,
      checkoutTotal: checkoutTotal ?? this.checkoutTotal,
    );
  }

  @override
  List<Object?> get props => [status, errorMsg, cartList, productDetailsList, quantities, checkoutTotal];
}
