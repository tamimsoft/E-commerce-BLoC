import 'package:ecommerce2/app/features/category/data/model/category_model.dart';
import 'package:ecommerce2/app/features/category/service/category_service.dart';
import 'package:ecommerce2/app/features/product/data/model/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryService _categoryService;

  CategoryBloc(this._categoryService) : super(CategoryState()) {
    on<CategoryEventLoadCategory>(_init);
    on<CategoryEventLoadCategoryProductList>(_onLoadCategoryProductList);
  }

  Future<void> _init(CategoryEventLoadCategory event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final List<CategoryModel> list = await _categoryService.getCategories();
      if (list.isNotEmpty) {
        emit(state.copyWith(status: Status.loaded, categoryList: list));
      } else if (list.isEmpty) {
        emit(state.copyWith(status: Status.empty, categoryList: []));
      }
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }
  Future<void> _onLoadCategoryProductList(CategoryEventLoadCategoryProductList event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final List<ProductModel> products = await _categoryService.getCategoryProducts(event.categoryId);
      if (products.isNotEmpty) {
        emit(state.copyWith(status: Status.loaded, categoryWiseProductList: products));
      } else if (products.isEmpty) {
        emit(state.copyWith(status: Status.empty, categoryWiseProductList: []));
      }
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }
}
