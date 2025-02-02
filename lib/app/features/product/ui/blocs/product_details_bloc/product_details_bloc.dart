import 'package:fakestore/app/features/product/data/model/product_details_model.dart';
import 'package:fakestore/app/features/product/service/product_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_event.dart';

part 'product_details_state.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final ProductService _productService;

  ProductDetailsBloc(this._productService) : super(ProductDetailsState()) {
    on<ProductDetailsEventLoad>(_init);
    on<ProductDetailsEventSelectColor>(_onChangeProductColor);
    on<ProductDetailsEventSelectSize>(_onChangeProductSize);
  }

  Future<void> _init(ProductDetailsEventLoad event, Emitter<ProductDetailsState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final productDetails = await _productService.getProductDetails(productId: event.productId);

      emit(state.copyWith(status: Status.loaded, productDetails: productDetails));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  Future<void> _onChangeProductColor(ProductDetailsEventSelectColor event, Emitter<ProductDetailsState> emit) async {
    emit(state.copyWith(colorName: event.selectedColor));
  }

  Future<void> _onChangeProductSize(ProductDetailsEventSelectSize event, Emitter<ProductDetailsState> emit) async {
    emit(state.copyWith(sizeName: event.selectedSize));
  }
}
