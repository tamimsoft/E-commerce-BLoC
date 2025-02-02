import 'package:fakestore/app/features/product/data/model/product_model.dart';
import 'package:fakestore/app/features/product/service/product_service.dart';
import 'package:fakestore/app/core/constants/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'new_product_event.dart';

part 'new_product_state.dart';

class NewProductBloc extends Bloc<NewProductEvent, NewProductState> {
  final ProductService _productService;

  NewProductBloc(this._productService) : super(NewProductState()) {
    on<NewProductEventLoadProduct>(_init);
  }

  Future<void> _init(
      NewProductEventLoadProduct event, Emitter<NewProductState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final List<ProductModel> list =
          await _productService.getProductsByRemark(remark: ProductRemark.newProduct);
      if (list.isNotEmpty) {
        emit(state.copyWith(status: Status.loaded, productList: list));
      } else {
        emit(state.copyWith(status: Status.empty, productList: []));
      }
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }
}
