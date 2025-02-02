import 'package:fakestore/app/features/cart/data/model/cart_model.dart';
import 'package:fakestore/app/features/cart/service/cart_service.dart';
import 'package:fakestore/app/features/product/data/model/product_details_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartService _cartService;
  List<CartModel> tempCartList = [];

  CartBloc(this._cartService) : super(CartState()) {
    on<CartEventLoadProduct>(_init);

    on<CartEventIncrementQuantity>(_onIncrementQuantity);
    on<CartEventDecrementQuantity>(_onDecrementQuantity);
    on<CartEventAddToCart>(_onPressAddToCartButton);
    on<CartEventRemoveProduct>(_onPressRemove);
  }

  Future<void> _init(CartEventLoadProduct event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      tempCartList.clear();
      tempCartList = await _cartService.getCartProducts();
      if (tempCartList.isEmpty) {
        emit(state.copyWith(status: Status.empty));
        return;
      } else {
        emit(state.copyWith(
          status: Status.loaded,
          cartList: tempCartList,
          checkoutTotal: getTotalAmount(),
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  void _onIncrementQuantity(CartEventIncrementQuantity event, Emitter<CartState> emit) async {
    final updatedQuantities = Map<int, int>.from(state.quantities);
    updatedQuantities[event.productId] = (updatedQuantities[event.productId] ?? 0) + 1;
    emit(state.copyWith(
      quantities: updatedQuantities,
      checkoutTotal: getTotalAmount(),
    ));
  }

  void _onDecrementQuantity(CartEventDecrementQuantity event, Emitter<CartState> emit) async {
    final updatedQuantities = Map<int, int>.from(state.quantities);
    final currentQuantity = updatedQuantities[event.productId] ?? 0;
    if (currentQuantity > 0) {
      updatedQuantities[event.productId] = currentQuantity - 1;
      emit(state.copyWith(
        quantities: updatedQuantities,
        checkoutTotal: getTotalAmount(),
      ));
    }
  }

  Future<void> _onPressAddToCartButton(CartEventAddToCart event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      tempCartList = await _cartService.getCartProducts();
      if (tempCartList.any((cart) => cart.productId == event.productId)) {
        emit(state.copyWith(status: Status.error, errorMsg: 'Product already exists in cart'));
        emit(state.copyWith(status: Status.loaded));
        return;
      }

      final cartModel = CartModel(
        productId: event.productId,
        quantity: event.quantity,
        colorName: event.colorName,
        sizeName: event.sizeName,
        price: event.price.toStringAsFixed(2),
      );

      await _cartService.addToCart(cartModel);
      tempCartList.add(cartModel); // Update local list
      emit(state.copyWith(
        status: Status.success,
        cartList: tempCartList,
        errorMsg: 'Product added to cart',
        checkoutTotal: getTotalAmount(),
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  Future<void> _onPressRemove(CartEventRemoveProduct event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      await _cartService.deleteCart(event.productId);
      tempCartList.removeWhere((cart) => cart.productId == event.productId);
      if (tempCartList.isEmpty) {
        emit(state.copyWith(status: Status.empty));
        return;
      } else {
        emit(state.copyWith(
          status: Status.loaded,
          cartList: tempCartList,
          checkoutTotal: getTotalAmount(),
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  // Calculate total price of all items in the cart
  double getTotalAmount() {
    return tempCartList.fold<double>(0, (total, cartItem) => total + double.parse(cartItem.price));
  }


}


