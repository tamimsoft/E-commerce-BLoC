part of 'category_bloc.dart';

enum Status { empty, loading, loaded, error }

class CategoryState extends Equatable {
  final Status status;
  final String errorMsg;
  final List<CategoryModel> categoryList;
  final List<ProductModel> categoryWiseProductList;

  const CategoryState({
    this.status = Status.empty,
    this.errorMsg = '',
    this.categoryList = const [],
    this.categoryWiseProductList = const [],
  });
  CategoryState copyWith({
    Status? status,
    String? errorMsg,
    List<CategoryModel>? categoryList,
    List<ProductModel>? categoryWiseProductList,
  }) {
    return CategoryState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      categoryList: categoryList ?? this.categoryList,
      categoryWiseProductList: categoryWiseProductList ?? this.categoryWiseProductList,
    );
  }

  @override
  List<Object?> get props => [status, errorMsg, categoryList, categoryWiseProductList];
}
