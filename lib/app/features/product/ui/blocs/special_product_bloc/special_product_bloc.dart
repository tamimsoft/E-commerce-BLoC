import 'package:ecommerce2/app/features/product/data/model/product_model.dart';
import 'package:ecommerce2/app/features/product/service/product_service.dart';
import 'package:ecommerce2/app/utils/constants/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'special_product_event.dart';

part 'special_product_state.dart';

class SpecialProductBloc extends Bloc<SpecialProductEvent, SpecialProductState> {
  final ProductService _productService;

  SpecialProductBloc(this._productService) : super(SpecialProductState()) {
    on<SpecialProductEventLoadProduct>(_init);
  }

  Future<void> _init(SpecialProductEventLoadProduct event, Emitter<SpecialProductState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final List<ProductModel> list = await _productService.getProductsByRemark(remark: ProductRemark.specialProduct);

      if (list.isNotEmpty) {
        emit(state.copyWith(status: Status.loaded, productList: list));
      }else{
        emit(state.copyWith(status: Status.empty, productList: []));
      }
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }
}
