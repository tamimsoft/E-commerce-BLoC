import 'package:fakestore/app/features/product/data/model/product_model.dart';
import 'package:fakestore/app/features/product/service/product_service.dart';
import 'package:fakestore/app/core/constants/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_product_event.dart';

part 'popular_product_state.dart';

class PopularProductBloc
    extends Bloc<PopularProductEvent, PopularProductState> {
  final ProductService _productService;

  PopularProductBloc(this._productService) : super(PopularProductState()) {
    on<PopularProductEventLoadProduct>(_init);
  }

  Future<void> _init(PopularProductEventLoadProduct event,
      Emitter<PopularProductState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final List<ProductModel> list = await _productService.getProductsByRemark(
          remark: ProductRemark.popularProduct);
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
